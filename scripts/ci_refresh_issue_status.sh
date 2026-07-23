#!/bin/bash
# SPDX-License-Identifier: CC0-1.0
# Copyright (C) 2026 Intel Corporation. All rights reserved.
#
# Refresh the open/closed marker that trails each issue link in a fail cell of
# results.md. The marker is a glyph span:
#   [#N](.../issues/N) <span class="issue-status issue-open">●</span>   (open)
#   [#N](.../issues/N) <span class="issue-status issue-closed">✓</span> (resolved)
# Run daily by the nightly-results workflow so the committed file stays honest
# even for visitors with JavaScript disabled.
#
# Only issues currently marked open are re-queried; a closed issue is terminal
# and left as-is, so this makes at most one API call per open issue.
#
# Usage: ci_refresh_issue_status.sh REPO RESULTS_FILE
# Requires: gh (authenticated via GH_TOKEN), python3.

set -euo pipefail

REPO="$1"
RESULTS_FILE="$2"

[[ -f "$RESULTS_FILE" ]] || { echo "no $RESULTS_FILE - nothing to refresh"; exit 0; }

# Collect issue numbers whose marker is currently open. The number sits in the
# link that immediately precedes the open glyph span.
mapfile -t open_nums < <(
	grep -oE "issues/[0-9]+\) <span class=\"issue-status issue-open\">" "$RESULTS_FILE" \
		| grep -oE 'issues/[0-9]+' | grep -oE '[0-9]+' | sort -u
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

# Flip the marker span for each closed issue, matching only that issue's link so
# other markers (including a second issue in the same row) are left untouched.
python3 - "$RESULTS_FILE" "${closed_nums[@]}" << 'PYEOF'
import re
import sys

path = sys.argv[1]
closed = set(sys.argv[2:])
CLOSED_GLYPH = '✓'  # ✓

with open(path) as f:
    text = f.read()

def repl(m):
    if m.group(1) not in closed:
        return m.group(0)
    return (f'issues/{m.group(1)}) '
            f'<span class="issue-status issue-closed">{CLOSED_GLYPH}</span>')

text = re.sub(
    r'issues/(\d+)\) <span class="issue-status issue-open">[^<]*</span>',
    repl, text)

with open(path, 'w') as f:
    f.write(text)
PYEOF

echo "refreshed status for: ${closed_nums[*]}"
