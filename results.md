# NDCTL Test Runner — Nightly Results

Automated daily testing of upstream kernel branches against ndctl/pending:

- **cxl/next** — https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git (cxl tests)
- **cxl/fixes** — https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git (cxl tests)
- **nvdimm/for-next** — https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git (nvdimm + dax tests)
- **nvdimm/fixes** — https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git (nvdimm + dax tests)
- **linux-next** — https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (cxl + nvdimm + dax tests)

**Legend:**
- `pass` = unit tests passed
- `fail` = unit tests failed OR build failed OR workflow failed
- `skip` = branch unchanged since last successful run
- `—` = not run today

| Date | cxl/next | cxl/fixes | nvdimm/for-next | nvdimm/fixes | linux-next |
|------|:--------:|:---------:|:---------------:|:------------:|:----------:|
| 2026-04-20 | skip | skip | skip | skip | skip |
| 2026-04-19 | skip | skip | skip | skip | skip |
| 2026-04-18 | [pass](https://github.com/pmem/ndctl-test-runner/actions/runs/24597877527) | [pass](https://github.com/pmem/ndctl-test-runner/actions/runs/24598073311) | [pass](https://github.com/pmem/ndctl-test-runner/actions/runs/24598121074) | [pass](https://github.com/pmem/ndctl-test-runner/actions/runs/24598096412) | [pass](https://github.com/pmem/ndctl-test-runner/actions/runs/24598099329) |
| 2026-04-16 | [pass](https://github.com/pmem/ndctl-test-runner/actions/runs/24497568304) | [fail](https://github.com/pmem/ndctl-test-runner/actions/runs/24527494181) | [pass](https://github.com/pmem/ndctl-test-runner/actions/runs/24497288926) | [pass](https://github.com/pmem/ndctl-test-runner/actions/runs/24498382832) | [pass](https://github.com/pmem/ndctl-test-runner/actions/runs/24498495818) |
| 2026-04-15 | — | — | — | — | — |

---

## Notes

**2026-04-16** - cxl/fixes failed due to apt network timeout, not a real failure. Re-ran manually and passed.

**2026-04-15** - Moving day, tests not run.
