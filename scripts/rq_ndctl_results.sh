#!/bin/bash
# SPDX-License-Identifier: CC0-1.0
# Copyright (C) 2021 Intel Corporation. All rights reserved.

logfile="$1"

find_lines_re=(
	"auto-running .*rq_ndctl_tests.sh"
	"Ok:[ \\t]+[0-9]+"
	"Done .*rq_ndctl_tests.sh"
)

warn_lines_re=(
	".*-+\\[ cut here \\]-+"
	".*-+\\[ end trace [0-9a-f]+ \\]-+"
	"Call Trace:"
	"kernel BUG"
	"[0-9]+/[0-9]+.*FAIL"
	'Fail:[[:blank:]]+[^0[:blank:]]'
	'Timeout:[[:blank:]]+[^0[:blank:]]'
)

raw_command_re=(
	".*raw command path used"
)

# Only infrastructure failures fail the workflow: build errors or the guest
# not completing (caught above by missing find_lines_re entries).
# Individual test failures are reported via warn_lines_re but do not fail
# the workflow — that would prevent ccache from being saved.
error_lines_re=(
	"make:.*\\[Makefile:.*check] Error"
	"ninja: build stopped: subcommand failed"
)

warn_count=0

profile_name()
{
	local profile
	profile=$(sed -n 's/^.*test profile: \(.*\) ========$/\1/p' "$logfile" | head -n1)
	if [[ -n "$profile" ]]; then
		printf '%s' "$profile"
	else
		printf 'NDCTL'
	fi
}

grep_summary()
{
	local re e_regs=()
	for re in "${find_lines_re[@]}" "${error_lines_re[@]}" "${warn_lines_re[@]}"; do
		e_regs+=('-e' "$re")
	done
	grep -n -E "${e_regs[@]}" "$logfile" | head -n 200
}

print_box()
{
	local color="$1"
	shift
	local lines=("$@")
	local width=0 line border

	for line in "${lines[@]}"; do
		((${#line} > width)) && width=${#line}
	done
	border=$(printf '+-%*s-+' "$width" '' | tr ' ' '-')

	if command -v tput >/dev/null 2>&1; then
		tput bold 2>/dev/null || true
		tput setaf "$color" 2>/dev/null || true
	fi
	printf '%s\n' "$border"
	for line in "${lines[@]}"; do
		printf '| %-*s |\n' "$width" "$line"
	done
	printf '%s\n' "$border"
	if command -v tput >/dev/null 2>&1; then
		tput sgr0 2>/dev/null || true
	fi
}

exit_success()
{
	print_box 2 "$(profile_name) Tests - Success"
	exit 0
}

exit_fail()
{
	local reason="$1"
	print_box 1 "$(profile_name) Tests - FAIL" "$reason"
	exit 1
}

exit_warn()
{
	print_box 3 "$(profile_name) Tests - Success" "with warnings - see log" "warn_count: $warn_count"
	exit 0
}

for re in "${find_lines_re[@]}"; do
	if grep -qE "$re" "$logfile"; then
		continue
	fi

	grep_summary
	exit_fail "failed to find line: $re"
done

for re in "${error_lines_re[@]}"; do
	if grep -qE "$re" "$logfile"; then
		grep_summary
		exit_fail "found error line: $re"
	fi
done

for re in "${warn_lines_re[@]}"; do
	if grep -qE "$re" "$logfile"; then
		warn_count=$((warn_count + 1))
	fi
done

for re in "${raw_command_re[@]}"; do
	if grep -qE "$re" "$logfile"; then
		warn_count=$((warn_count - 4))
	fi
done

if (( warn_count > 0 )); then
	grep_summary
	exit_warn
fi

exit_success
