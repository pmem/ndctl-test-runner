#!/bin/bash
# SPDX-License-Identifier: CC0-1.0
# Update historical results with new formatting:
# 1. Make 'fail' bold and red
# 2. Add skip count to 'pass' results

set -euo pipefail

REPO="${REPO:-pmem/ndctl-test-runner}"
RESULTS_FILE="${1:-results.md}"

echo "Updating historical results with new formatting..."

if [[ ! -f "$RESULTS_FILE" ]]; then
  echo "Error: $RESULTS_FILE not found"
  exit 1
fi

# Create a backup
cp "$RESULTS_FILE" "${RESULTS_FILE}.backup"
echo "Created backup: ${RESULTS_FILE}.backup"

# Extract unique run IDs for pass and fail
echo "Extracting run IDs..."
pass_ids=$(grep -oE 'runs/[0-9]+' "$RESULTS_FILE" | grep -v 'fail' | cut -d/ -f2 | sort -u || true)
fail_ids=$(grep 'fail.*runs/' "$RESULTS_FILE" | grep -oE 'runs/[0-9]+' | cut -d/ -f2 | sort -u || true)

# Process fail entries first (simpler - just update formatting)
echo "Processing fail entries..."
for run_id in $fail_ids; do
  echo "  Updating run $run_id to bold red fail"
  sed -i "s|\[fail\](https://github.com/$REPO/actions/runs/$run_id)|[**<span style=\"color:red\">fail</span>**](https://github.com/$REPO/actions/runs/$run_id)|g" "$RESULTS_FILE"
done

# Process pass entries - try to add skip counts
echo "Processing pass entries..."
processed=0
total=$(echo "$pass_ids" | wc -w)

for run_id in $pass_ids; do
  processed=$((processed + 1))
  # Skip if already updated from a fail (shouldn't happen but be safe)
  if echo "$fail_ids" | grep -q "$run_id"; then
    continue
  fi

  echo "  [$processed/$total] Processing pass run $run_id..."

  # Get workflow path to determine artifact name
  workflow=$(gh api "repos/$REPO/actions/runs/$run_id" --jq '.path' 2>/dev/null | sed 's|.github/workflows/||' | sed 's|.yml||' || echo "")

  if [[ -z "$workflow" ]]; then
    echo "    - Could not determine workflow"
    continue
  fi

  artifact_name="logs-$workflow"
  skip_count=""

  # Try to download artifact and count skips
  if gh run download "$run_id" -n "$artifact_name" -D "/tmp/artifact-$run_id" 2>/dev/null; then
    skip_count=$(grep -E "Skipped:[ \t]+[0-9]+" "/tmp/artifact-$run_id/tmp/rq_0.log" 2>/dev/null \
      | awk '{print $NF}' | head -1 || echo "")
    rm -rf "/tmp/artifact-$run_id"

    if [[ -n "$skip_count" ]] && [[ "$skip_count" -gt 0 ]]; then
      # Update pass to pass [N]
      sed -i "s|\[pass\](https://github.com/$REPO/actions/runs/$run_id)|[pass [$skip_count]](https://github.com/$REPO/actions/runs/$run_id)|g" "$RESULTS_FILE"
      echo "    ✓ Updated to pass [$skip_count]"
    else
      echo "    - No skipped tests"
    fi
  else
    echo "    - Could not download artifact (may be expired)"
  fi
done

# Update the legend
echo "Updating legend..."
sed -i "s|- \`pass\` = unit tests passed$|- \`pass\` = unit tests passed (pass [N] means N tests were skipped)|" "$RESULTS_FILE"

# Update header section with embedded links
echo "Updating header links..."
sed -i "s|Tests are run against the ndctl pending branch\.|Tests are run against the [ndctl pending branch](https://github.com/pmem/ndctl/tree/pending).|" "$RESULTS_FILE"
sed -i "s|- \*\*cxl/next\*\*: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git (cxl tests)|- **[cxl/next](https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=next)**:		CXL unit tests|" "$RESULTS_FILE"
sed -i "s|- \*\*cxl/fixes\*\*: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git (cxl tests)|- **[cxl/fixes](https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=fixes)**:		CXL unit tests|" "$RESULTS_FILE"
sed -i "s|- \*\*nvdimm/for-next\*\*: https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git (nvdimm + dax tests)|- **[nvdimm/for-next](https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=for-next)**:	NVDIMM, DAX unit tests|" "$RESULTS_FILE"
sed -i "s|- \*\*nvdimm/fixes\*\*: https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git (nvdimm + dax tests)|- **[nvdimm/fixes](https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=fixes)**:		NVDIMM, DAX unit tests|" "$RESULTS_FILE"
sed -i "s|- \*\*linux-next\*\*: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (cxl + nvdimm + dax tests)|- **[linux-next](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=master)**:		CXL, NVDIMM, DAX unit tests (all)|" "$RESULTS_FILE"

echo ""
echo "Done! Review changes: diff ${RESULTS_FILE}.backup ${RESULTS_FILE}"
echo "To restore backup: mv ${RESULTS_FILE}.backup ${RESULTS_FILE}"
