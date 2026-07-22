#!/bin/bash
# SPDX-License-Identifier: CC0-1.0
# Copyright (C) 2026 Intel Corporation. All rights reserved.
#
# Open a GitHub issue for a failed CI run, with an automatically triaged
# failure signature pulled from the run log. Prints the created issue URL on
# stdout so the caller can drop a link into the results table.
#
# Usage:
#   ci_open_issue.sh REPO TITLE SCOPE DATE RUN_URL [LOG_FILE]
#
# LOG_FILE is the extracted rq_0.log for the run. If it is missing or empty
# (e.g. the artifact has expired), the issue is still filed with a note that
# no signature could be recovered.
#
# Requires: gh (authenticated via GH_TOKEN), grep, awk.

set -euo pipefail

REPO="$1"
TITLE="$2"
SCOPE="$3"
DATE="$4"
RUN_URL="$5"
LOG_FILE="${6:-}"

# --- Extract a failure signature ---------------------------------------------
# Detect whether this was a kernel/ndctl build break or a unit-test failure,
# then grab the handful of lines that best characterize it. Mirrors the marker
# vocabulary used by scripts/rq_ndctl_results.sh.

sig_type="unknown"
sig_body=""

if [[ -n "$LOG_FILE" && -s "$LOG_FILE" ]]; then
	# Build break: compiler errors or make/ninja stopping.
	if grep -qE 'make:.*Error|make\[[0-9]+\]:.*Error|ninja: build stopped|cc1: all warnings being treated as errors|error:' "$LOG_FILE"; then
		sig_type="kernel/ndctl build failure"
		sig_body=$(grep -nE 'error:|-Werror|cc1: all warnings|\*\*\* \[.*\] Error [0-9]+|ninja: build stopped' "$LOG_FILE" \
			| head -n 15 | cut -d: -f2-)
	# Test failure: per-test FAIL lines, non-zero Fail:/Timeout:, or a crash.
	elif grep -qE '[0-9]+/[0-9]+.*FAIL|Fail:[[:blank:]]+[^0[:blank:]]|Timeout:[[:blank:]]+[^0[:blank:]]|kernel BUG|Call Trace:' "$LOG_FILE"; then
		sig_type="unit test failure"
		sig_body=$(grep -nE '[0-9]+/[0-9]+.*FAIL|Fail:[[:blank:]]+[^0[:blank:]]|Timeout:[[:blank:]]+[^0[:blank:]]|kernel BUG|Call Trace:|Ok:[[:blank:]]+[0-9]+' "$LOG_FILE" \
			| head -n 20 | cut -d: -f2-)
	else
		sig_type="unclassified failure"
		# Fall back to the tail, which usually holds the fatal message.
		sig_body=$(tail -n 20 "$LOG_FILE")
	fi
fi

# --- Assemble the issue body -------------------------------------------------

body_file=$(mktemp)
{
	printf '**Scope:** %s\n' "$SCOPE"
	printf '**Date:** %s\n' "$DATE"
	printf '**Result:** fail\n'
	printf '**Run:** %s _(log artifact retained ~30 days from the run date)_\n\n' "$RUN_URL"

	printf '## Failure signature\n\n'
	if [[ -n "$sig_body" ]]; then
		printf '**Type:** %s\n\n' "$sig_type"
		printf '```\n%s\n```\n' "$sig_body"
	else
		printf 'No failure signature could be extracted automatically '
		printf '(log unavailable or empty). See the run link above while it is retained.\n'
	fi

	printf '\n_Filed automatically by the ndctl-test-runner CI on failure._\n'
} > "$body_file"

# --- Create the issue --------------------------------------------------------

issue_url=$(gh issue create --repo "$REPO" --title "$TITLE" --body-file "$body_file")
rm -f "$body_file"

printf '%s\n' "$issue_url"
