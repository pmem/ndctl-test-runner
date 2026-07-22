#!/bin/bash
# SPDX-License-Identifier: CC0-1.0
# Copyright (C) 2026 Intel Corporation. All rights reserved.
#
# Refresh the "(open)"/"(closed)" status word that trails each issue link in the
# Issues column of results.md. Run daily by the nightly-results workflow so the
# committed file stays honest even for visitors with JavaScript disabled.
#
# Only issues currently marked "(open)" are re-queried; a closed issue is
# terminal and left as-is, so this makes at most one API call per open issue.
#
# Usage: ci_refresh_issue_status.sh REPO RESULTS_FILE
# Requires: gh (authenticated via GH_TOKEN), python3.

set -euo pipefail

REPO="$1"
RESULTS_FILE="$2"

[[ -f "$RESULTS_FILE" ]] || { echo "no $RESULTS_FILE - nothing to refresh"; exit 0; }

# Collect issue numbers that are currently marked open in the file.
mapfile -t open_nums < <(
	grep -oE "issues/[0-9]+\) \(open\)" "$RESULTS_FILE" \
		| grep -oE '[0-9]+' | sort -u
)

if [[ ${#open_nums[@]} -eq 0 ]]; then
	echo "no open issue links to refresh"
	exit 0
fi

# Query current state for each and record those that are now closed.
closed_nums=()
for n in "${open_nums[@]}"; do
	state=$(gh issue view "$n" --repo "$REPO" --json state --jq .state 2>/dev/null || echo "")
	if [[ "$state" == "CLOSED" ]]; then
		closed_nums+=("$n")
		echo "issue #$n is now closed"
	fi
done

if [[ ${#closed_nums[@]} -eq 0 ]]; then
	echo "no open->closed transitions"
	exit 0
fi

# Flip the trailing word for each closed issue, matching only that issue's link.
python3 - "$RESULTS_FILE" "${closed_nums[@]}" << 'PYEOF'
import re
import sys

path = sys.argv[1]
closed = set(sys.argv[2:])

with open(path) as f:
    text = f.read()

def repl(m):
    return f'issues/{m.group(1)}) (closed)' if m.group(1) in closed else m.group(0)

text = re.sub(r'issues/(\d+)\) \(open\)', repl, text)

with open(path, 'w') as f:
    f.write(text)
PYEOF

echo "refreshed status for: ${closed_nums[*]}"
