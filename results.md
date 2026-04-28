# NDCTL Test Runner

## Linus Mainline Release Tags

Tests are run against Linus mainline release tags from [torvalds/linux](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git), using the [ndctl pending branch](https://github.com/pmem/ndctl/tree/pending).

| Kernel tag | Tag date | Tested at | Result | Attempts | Notes |
|------------|----------|-----------|--------|----------|-------|

## Daily Run Results

Tests are run against the [ndctl pending branch](https://github.com/pmem/ndctl/tree/pending).

- **[cxl/next](https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=next)**:		CXL unit tests
- **[cxl/fixes](https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=fixes)**:		CXL unit tests
- **[nvdimm/for-next](https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=for-next)**:	NVDIMM, DAX unit tests
- **[nvdimm/fixes](https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=fixes)**:		NVDIMM, DAX unit tests
- **[linux-next](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=master)**:		CXL, NVDIMM, DAX unit tests (all)

Click through on the pass/fail results to lookup the kernel and ndctl SHA under test.

<div id="results-table-container" markdown="1">

| Date | cxl/next | cxl/fixes | nvdimm/for-next | nvdimm/fixes | linux-next |
|------|:--------:|:---------:|:---------------:|:------------:|:----------:|
| 2026-04-28 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25034144009) |
| 2026-04-27 | — | — | — | — | — |
| 2026-04-26 | — | — | — | — | — |
| 2026-04-25 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24921958625) |
| 2026-04-24 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24871982445) |
| 2026-04-23 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24816367663) |
| 2026-04-22 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24759704519) |
| 2026-04-21 | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24703524511) | — | — |
| 2026-04-21 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24700726311) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24700728870) [2] | [<span style="color:red">fail</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24700730266) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24700731725) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24700733076) |
| 2026-04-20 | — | — | — | — | — |
| 2026-04-19 | — | — | — | — | — |
| 2026-04-18 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24597877527) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24598073311) [2] | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24598121074) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24598096412) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24598099329) |
| 2026-04-16 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24497568304) | [<span style="color:red">fail</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24527494181) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24497288926) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24498382832) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24498495818) |

<div id="pagination-controls" style="margin: 20px 0; text-align: center; display: flex; justify-content: center; align-items: center;">
  <button id="prev-btn" style="padding: 5px 10px; margin: 0 5px; cursor: pointer; font-size: 0.85em;">← prev</button>
  <span id="page-info" style="margin: 0 10px; font-size: 0.9em;"></span>
  <button id="next-btn" style="padding: 5px 10px; margin: 0 5px; cursor: pointer; font-size: 0.85em;">next →</button>
</div>

</div>

<script>
(function() {
  const ROWS_PER_PAGE = 12;
  let currentPage = 1;
  let allRows = [];
  
  function init() {
    const container = document.getElementById('results-table-container');
    if (!container) return;
    
    const table = container.querySelector('table');
    if (!table) return;
    
    const tbody = table.querySelector('tbody');
    if (!tbody) return;
    
    // Get all data rows (exclude header rows)
    allRows = Array.from(tbody.querySelectorAll('tr'));
    
    if (allRows.length <= ROWS_PER_PAGE) {
      // Hide pagination if not needed
      document.getElementById('pagination-controls').style.display = 'none';
      return;
    }
    
    showPage(1);
    updateButtons();
    
    document.getElementById('prev-btn').addEventListener('click', () => {
      if (currentPage > 1) {
        currentPage--;
        showPage(currentPage);
        updateButtons();
      }
    });
    
    document.getElementById('next-btn').addEventListener('click', () => {
      const totalPages = Math.ceil(allRows.length / ROWS_PER_PAGE);
      if (currentPage < totalPages) {
        currentPage++;
        showPage(currentPage);
        updateButtons();
      }
    });
  }
  
  function showPage(page) {
    const start = (page - 1) * ROWS_PER_PAGE;
    const end = start + ROWS_PER_PAGE;
    
    allRows.forEach((row, index) => {
      row.style.display = (index >= start && index < end) ? '' : 'none';
    });
  }
  
  function updateButtons() {
    const totalPages = Math.ceil(allRows.length / ROWS_PER_PAGE);
    
    document.getElementById('prev-btn').disabled = currentPage === 1;
    document.getElementById('next-btn').disabled = currentPage === totalPages;
    document.getElementById('page-info').textContent = `Page ${currentPage} of ${totalPages}`;
  }
  
  // Run after page loads
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
</script>

**Legend:**
- <span style="color:green">pass</span> = unit tests passed (pass [N] means N tests were skipped)
- <span style="color:red">fail</span> = unit tests failed OR build failed OR workflow failed
- `—` = testing skipped, both kernel and ndctl branches were unchanged since last successful run

---

## Notes

**2026-04-21** - btt-check.sh failed for BTT race condition. Patches posted:
  - [nvdimm/btt: Handle preemption in BTT lane acquisition](https://lore.kernel.org/nvdimm/20260424234405.3762827-1-alison.schofield@intel.com/)
  - [test/btt-stress.sh: add stress test for BTT lane race](https://lore.kernel.org/nvdimm/20260424233633.3762217-1-alison.schofield@intel.com/)

**2026-04-16** - cxl/fixes failed due to apt network timeout, not a real failure. Re-ran manually and passed.
