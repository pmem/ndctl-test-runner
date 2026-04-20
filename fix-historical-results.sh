#!/bin/bash
set -euo pipefail

# Fix historical results.md on gh-pages branch
# Checks each "pass" entry to see if it was actually a skip

REPO="${GITHUB_REPOSITORY:-pmem/ndctl-test-runner}"

git fetch origin gh-pages
git checkout gh-pages

status_of() {
  local date=$1 workflow=$2

  # Get the run for this date
  local run_id conclusion
  read -r run_id conclusion < <(
    gh api "repos/$REPO/actions/workflows/$workflow/runs?per_page=10" \
      --jq ".workflow_runs[] | select(.created_at | startswith(\"$date\")) | \"\(.id) \(.conclusion)\"" \
      | head -1
  )

  [[ -z "$run_id" ]] && { echo "—"; return; }

  local run_url="https://github.com/$REPO/actions/runs/$run_id"

  if [[ "$conclusion" == "failure" ]]; then
    echo "[fail]($run_url)"
    return
  fi

  # Check test job conclusion - job name can be "test" or "test / build"
  local test_conclusion
  test_conclusion=$(gh api "repos/$REPO/actions/runs/$run_id/jobs" \
    --jq '[.jobs[] | select(.name | startswith("test"))][0].conclusion // "none"')

  if [[ "$test_conclusion" == "success" ]]; then
    echo "[pass]($run_url)"
  elif [[ "$test_conclusion" == "skipped" ]]; then
    echo "skip"
  else
    # No test job found - shouldn't happen but treat as skip
    echo "skip"
  fi
}

# Process each date in results.md
while IFS='|' read -r _ date cxl_next cxl_fixes for_next nvdimm_fixes linux_next _; do
  # Skip header rows
  [[ "$date" =~ ^[[:space:]]*Date[[:space:]]*$ ]] && continue
  [[ "$date" =~ ^[[:space:]]*-+[[:space:]]*$ ]] && continue

  # Trim whitespace from all fields
  date=$(echo "$date" | xargs)
  cxl_next=$(echo "$cxl_next" | xargs)
  cxl_fixes=$(echo "$cxl_fixes" | xargs)
  for_next=$(echo "$for_next" | xargs)
  nvdimm_fixes=$(echo "$nvdimm_fixes" | xargs)
  linux_next=$(echo "$linux_next" | xargs)

  [[ -z "$date" ]] && continue

  echo "Checking $date..."

  new_cxl_next=$(status_of "$date" "nightly-cxl-next.yml")
  new_cxl_fixes=$(status_of "$date" "nightly-cxl-fixes.yml")
  new_for_next=$(status_of "$date" "nightly-nvdimm-for-next.yml")
  new_nvdimm_fixes=$(status_of "$date" "nightly-nvdimm-fixes.yml")
  new_linux_next=$(status_of "$date" "nightly-linux-next.yml")

  old_row="| $date | $cxl_next | $cxl_fixes | $for_next | $nvdimm_fixes | $linux_next |"
  new_row="| $date | $new_cxl_next | $new_cxl_fixes | $new_for_next | $new_nvdimm_fixes | $new_linux_next |"

  if [[ "$old_row" != "$new_row" ]]; then
    echo "  Updating: $date"
    # Use python for reliable replacement
    python3 <<PYEOF
import sys
with open('results.md', 'r') as f:
    content = f.read()
content = content.replace('''$old_row''', '''$new_row''')
with open('results.md', 'w') as f:
    f.write(content)
PYEOF
  fi
done < <(grep '^|' results.md)

echo "Done. Review changes with: git diff results.md"
