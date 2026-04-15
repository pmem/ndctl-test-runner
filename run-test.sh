#!/bin/bash
# SPDX-License-Identifier: CC0-1.0
# Trigger the ndctl-test runner workflow from the command line.
# All flags are optional — unset flags use the workflow's own defaults.
#
# Usage examples:
#   ./run-test.sh
#   ./run-test.sh -b next -n v84 -s cxl
#   ./run-test.sh -b fixes -s nvdimm
#   ./run-test.sh -b next -s all -t 50
#   ./run-test.sh --watch

set -euo pipefail

REPO="AlisonSchofield/ndctl-test-runner"
WORKFLOW="ndctl-test runner"
WORKFLOW_REF="testing"

kernel_branch=""
kernel_repo=""
ndctl_branch=""
ndctl_repo=""
test_suite=""
timeout_min=""
watch=0

usage() {
	cat <<EOF
Usage: $0 [options]

  -k, --kernel-repo REPO     kernel repo (owner/name or full URL)
  -b, --kernel-branch BRANCH kernel branch, tag, or SHA
  -n, --ndctl-branch BRANCH  ndctl branch, tag, or SHA
  -N, --ndctl-repo REPO      ndctl repo (owner/name or full URL)
  -s, --suite SUITE          test suite: all, cxl, nvdimm, dax (or combined)
  -t, --timeout MIN          guest timeout in minutes
  -w, --watch                watch the run after triggering
  -h, --help                 show this help

Unspecified options use the workflow's own defaults:
  kernel_repo:   AlisonSchofield/linux-kernel
  kernel_branch: cxl-testme
  ndctl_repo:    pmem/ndctl
  ndctl_branch:  pending
  test_suite:    all
  timeout_min:   35
EOF
	exit 0
}

while [[ $# -gt 0 ]]; do
	case "$1" in
		-k|--kernel-repo)    kernel_repo="$2";    shift 2 ;;
		-b|--kernel-branch)  kernel_branch="$2";  shift 2 ;;
		-N|--ndctl-repo)     ndctl_repo="$2";     shift 2 ;;
		-n|--ndctl-branch)   ndctl_branch="$2";   shift 2 ;;
		-s|--suite)          test_suite="$2";      shift 2 ;;
		-t|--timeout)        timeout_min="$2";     shift 2 ;;
		-w|--watch)          watch=1;              shift ;;
		-h|--help)           usage ;;
		*) echo "Unknown option: $1" >&2; usage ;;
	esac
done

args=()
[[ -n "$kernel_repo" ]]   && args+=(-f "kernel_repo=$kernel_repo")
[[ -n "$kernel_branch" ]] && args+=(-f "kernel_branch=$kernel_branch")
[[ -n "$ndctl_repo" ]]    && args+=(-f "ndctl_repo=$ndctl_repo")
[[ -n "$ndctl_branch" ]]  && args+=(-f "ndctl_branch=$ndctl_branch")
[[ -n "$test_suite" ]]    && args+=(-f "test_suite=$test_suite")
[[ -n "$timeout_min" ]]   && args+=(-f "timeout_min=$timeout_min")

echo "Triggering: $WORKFLOW"
[[ ${#args[@]} -gt 0 ]] && printf '  %s\n' "${args[@]}"

gh workflow run "$WORKFLOW" --repo "$REPO" --ref "$WORKFLOW_REF" "${args[@]}"

if (( watch )); then
	sleep 3
	gh run watch --repo "$REPO"
fi
