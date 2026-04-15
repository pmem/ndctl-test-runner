# NDCTL Test Runner

NDCTL Test Runner is a GitHub Actions workflow that builds a Linux kernel,
boots it in QEMU using run_qemu_ci.sh, and executes the ndctl test suites
for CXL, NVDIMM, and DAX. It runs entirely on GitHub-hosted infrastructure
with no special hardware required.

This repository serves two purposes:

**Scheduled testing of upstream kernel branches** — five workflows run
daily against the major CXL, NVDIMM, and linux-next kernel trees, each
tested against ndctl/pending. See [Scheduled Runs](#scheduled-runs).

**A reusable test runner for kernel developers** — fork this repository to
run tests against your own kernel branches. Tests can be launched four ways:

- From the **Actions tab** in your fork — [Quick Start](#quick-start)
- From the **command line** using the GitHub CLI — [Running From The Command Line](#running-from-the-command-line)
- Using the included **run-test.sh** wrapper — [Using run-test.sh](#using-run-testsh)
- **Automatically on push**, triggered from your kernel repository — [Automatically Trigger Tests](#automatically-trigger-tests-from-your-kernel-repository)


## Scheduled Runs

Five workflows run automatically each day at 06:00 UTC,
one per branch under test:

- `cxl/next` — cxl/cxl.git, cxl tests
- `cxl/fixes` — cxl/cxl.git, cxl tests
- `libnvdimm/for-next` — nvdimm/nvdimm.git, nvdimm and dax tests
- `libnvdimm/fixes` — nvdimm/nvdimm.git, nvdimm and dax tests
- `linux-next/master` — next/linux-next.git, cxl, nvdimm, and dax tests

TODO: Add a weekly workflow to test new Linus release candidate tags (mainline).

Each workflow appears as a separate entry in the **Actions** tab. Scheduled
runs are labeled `(schedule)` in the run list.

All five workflows use SHA deduplication: if neither the kernel branch nor
ndctl/pending has changed since the last successful run, the test is skipped
and no runner time is consumed.

Each workflow can also be triggered manually at any time from the Actions tab
using the **Run workflow** button.

When a scheduled run has test failures or skips, the full `rq_0.log` is
uploaded as a workflow artifact and can be downloaded from the run page for
detailed per-test analysis.


## Quick Start

1. Fork this repository.

2. Open the **Actions** tab in your fork.

3. Select **ndctl-test runner**.

4. Click **Run workflow**.

5. Provide your kernel repository and branch.

Repository inputs may be either:

- a GitHub repository in `owner/name` form
- a full git URL (for example a kernel.org maintainer tree)


## Try It Now

You can immediately test the current CXL maintainer tree.

Example inputs:

```
kernel_repo: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
kernel_branch: next
ndctl_repo: pmem/ndctl
ndctl_branch: pending
test_suite: cxl
timeout_min: 35
```

This runs the ndctl CXL test suite against the current CXL maintainer
next branch in QEMU.


## Workflow Inputs

| Input | Description | Default |
|-------|-------------|---------|
| `kernel_repo` | Kernel repo: `owner/name` or full git URL | _(required)_ |
| `kernel_branch` | Kernel branch, tag, or SHA | _(required)_ |
| `ndctl_repo` | ndctl repo: `owner/name` or full git URL | `pmem/ndctl` |
| `ndctl_branch` | ndctl branch, tag, or SHA | `pending` |
| `test_suite` | Test suites to run (see below) | `all` |
| `timeout_min` | Guest timeout in minutes | `35` |

### test_suite values

| Value | Test suites run |
|-------|----------------|
| `all` | CXL, NVDIMM, and DAX tests |
| `cxl` | CXL unit tests only |
| `nvdimm` | NVDIMM (nfit) tests only |
| `dax` | DAX tests only |

Space-separated combinations are also accepted (for example `nvdimm dax`).


## Example Inputs

Example using a GitHub kernel repository (CXL testing):

```
kernel_repo: yourname/linux
kernel_branch: cxl-feature-branch
ndctl_repo: pmem/ndctl
ndctl_branch: pending
test_suite: cxl
timeout_min: 35
```

Example using a kernel.org maintainer tree (all suites):

```
kernel_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel_branch: master
ndctl_repo: pmem/ndctl
ndctl_branch: pending
test_suite: all
timeout_min: 45
```


## Running From The Command Line

Tests can be triggered from the command line using either the GitHub CLI
directly or the `run-test.sh` wrapper script included in this repository.

Both require the GitHub CLI to be installed and authenticated:

```
gh auth login
```

### Using the GitHub CLI directly

```
gh workflow run "ndctl-test runner" \
  --repo yourname/ndctl-test-runner \
  -f kernel_repo=https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git \
  -f kernel_branch=next \
  -f test_suite=cxl
```

```
gh workflow run "ndctl-test runner" \
  --repo yourname/ndctl-test-runner \
  -f kernel_repo=https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git \
  -f kernel_branch=libnvdimm-for-next \
  -f test_suite="nvdimm dax"
```

```
gh workflow run "ndctl-test runner" \
  --repo yourname/ndctl-test-runner \
  -f kernel_repo=yourname/linux \
  -f kernel_branch=my-feature-branch \
  -f test_suite=cxl
```

Watch the run:

```
gh run watch --repo yourname/ndctl-test-runner
```

### Using run-test.sh

`run-test.sh` is a wrapper around the GitHub CLI that shortens common
invocations. Edit the `REPO` variable at the top of the script to point
to your fork before using it.

```
# CXL next branch
./run-test.sh -k https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git \
              -b next -s cxl

# NVDIMM for-next branch
./run-test.sh -k https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git \
              -b libnvdimm-for-next -s "nvdimm dax"

# Your own kernel branch
./run-test.sh -k yourname/linux -b my-feature-branch -s cxl
```

Trigger and watch in one step:

```
./run-test.sh -k yourname/linux -b my-feature-branch -s cxl --watch
```


## Example Test Output

The workflow summary displays the results of each test. Example CXL output:

```
1/16 ndctl:cxl / cxl-topology.sh        OK      3.21s
2/16 ndctl:cxl / cxl-region-sysfs.sh    OK      8.43s
3/16 ndctl:cxl / cxl-labels.sh          OK      4.17s
4/16 ndctl:cxl / cxl-create-region.sh   OK     12.85s
5/16 ndctl:cxl / cxl-xor-region.sh      OK     18.62s
...
16/16 ndctl:cxl / cxl-poison.sh         OK      5.30s

Ok:                 16
Fail:               0
Skipped:            0
Timeout:            0
```

When tests fail, a summary of failures is shown in the workflow step log,
and the full `rq_0.log` is uploaded as an artifact for detailed analysis.


## Automatically Trigger Tests From Your Kernel Repository

Developers may configure their kernel repository to automatically trigger
the NDCTL Test Runner whenever commits are pushed.

This works with **your fork** of ndctl-test-runner. You cannot trigger
runs in `pmem/ndctl-test-runner` directly. If you have a public branch
you would like added to the nightly runs in `pmem/ndctl-test-runner`
(temporarily or long-term), open an issue in this repository and ask.

Create the file `.github/workflows/ndctl-test.yml` in your kernel repo:

```yaml
name: run ndctl tests

on:
  push:
    branches:
      - cxl-*

jobs:
  trigger:
    runs-on: ubuntu-latest
    steps:
      - name: Trigger NDCTL Test Runner
        env:
          GH_TOKEN: ${{ secrets.NDCTL_RUNNER_TOKEN }}
        run: |
          gh workflow run "ndctl-test runner" \
            --repo yourname/ndctl-test-runner \
            -f kernel_repo=${{ github.repository }} \
            -f kernel_branch=${{ github.ref_name }} \
            -f test_suite=cxl
```


## Overview

This project packages the run_qemu_ci.sh testing environment into a
reproducible GitHub Actions workflow for automated ndctl test execution.

The runner performs the following steps:

1. Checkout the requested kernel repository and branch
2. Checkout the requested ndctl repository and branch
3. Build the kernel with ccache using a unified config for all test suites
4. Boot the kernel in QEMU using run_qemu_ci.sh
5. Execute the selected ndctl test suites (CXL, NVDIMM, DAX, or all)
6. Publish a test summary and upload logs when failures or skips occur

A unified kernel configuration (ci-base.cfg + cxl-test.cfg + nfit-test.cfg)
is always applied regardless of which test suite is selected. This maximizes
ccache hits: switching suites reuses the same binary, and iterating on kernel
patches only recompiles changed files rather than triggering config-driven
rebuilds across the tree.


## Test Environment

The workflow currently runs with the following configuration:

```
GitHub runner: ubuntu-24.04
Architecture:  x86_64
mkosi image:   ubuntu noble
```


## Relationship to run_qemu

https://github.com/pmem/run_qemu

This project builds on the run_qemu infrastructure originally developed
by Vishal Verma and expanded upon by Marc Herbert.

`run_qemu_ci.sh` is a CI-focused derivative of the upstream `run_qemu.sh`.
It retains the kernel build, rootfs image creation, and automated QEMU
boot and test execution, while removing all interactive features (SSH
access, networking setup, GDB integration, and developer convenience
tools) that are not needed for automated CI runs.
