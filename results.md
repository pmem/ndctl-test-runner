# NDCTL Test Runner

## Mainline Tag Results

All Unit Tests are run against Linus mainline release tags (vX.Y, vX.Y-rcN) using the [ndctl pending branch](https://github.com/pmem/ndctl/tree/pending). Each tag is tested once and may be rerun if needed. The table shows the latest result for each tag. Click pass/fail results to view logs and details (links are retained for 30 days).
- <span style="color:green">pass</span> = all tests passed (pass [N] means N tests were skipped)
- <span style="color:red">fail</span> = one or more failures occurred (test failure, build failure, or workflow/infrastructure failure)

| Kernel Tag | Date Tagged | Date Tested | Result | Attempts | Notes |
|------------|-------------|-------------|--------|----------|-------|
| v7.1-rc2 | 2026-05-03 | 2026-05-04 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25317995626) | 1 |  |
| v7.1-rc1 | 2026-04-26 | 2026-04-28 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25082127859) | 1 |  |
| v7.0 | 2026-04-12 | 2026-04-28 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25082119712) [2] | 1 |  |

## Daily Branch Results

Daily automated test runs against active development branches using the [ndctl pending branch](https://github.com/pmem/ndctl/tree/pending). Click pass/fail results to view logs and details (links are retained for 30 days).
- <span style="color:green">pass</span> = all tests passed (pass [N] means N tests were skipped)
- <span style="color:red">fail</span> = one or more failures occurred (test failure, build failure, or workflow/infrastructure failure)
- `—` = testing skipped, both kernel and ndctl branches unchanged since last successful run

<style>
#results-table-container table td:first-child {
  white-space: nowrap;
}
#results-table-container table td:last-child {
  font-size: 0.85em;
  min-width: 200px;
}
</style>

<div id="results-table-container" markdown="1">

| **Date (UTC)** | [cxl/next](https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=next) | [cxl/fixes](https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=fixes) | [nvdimm/next](https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=for-next) | [nvdimm/fixes](https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=fixes) | [linux-next](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=master) | Notes |
|----------|:--------------------:|:----------------------:|:-------------------------------------:|:------------------------------------:|:-----------------------------------:|-------|
| **Test Scope** | cxl | cxl | nvdimm/dax | nvdimm/dax | cxl/nvdimm/dax | |
|----------|:--------------------:|:----------------------:|:-------------------------------------:|:------------------------------------:|:-----------------------------------:|-------|
| 2026-05-04 | — | — | — | — | — |  |
| 2026-05-03 | — | — | — | — | — |  |
| 2026-05-02 | — | — | — | — | — |  |
| 2026-05-01 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25202347015) |  |
| 2026-04-30 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25147575656) |  |
| 2026-04-29 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25091032041) |  |
| 2026-04-28 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25034144009) |  |
| 2026-04-27 | — | — | — | — | — |  |
| 2026-04-26 | — | — | — | — | — |  |
| 2026-04-25 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24921958625) |  |
| 2026-04-24 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24871982445) |  |
| 2026-04-23 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24816367663) |  |
| 2026-04-22 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24759704519) |  |
| 2026-04-21 | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24703524511) | — | — |  |
| 2026-04-21 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24700726311) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24700728870) [2] | [<span style="color:red">fail</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24700730266) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24700731725) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24700733076) | btt-check.sh failed with race condition, [patch posted](https://lore.kernel.org/nvdimm/20260424234405.3762827-1-alison.schofield@intel.com/) |
| 2026-04-20 | — | — | — | — | — |  |
| 2026-04-19 | — | — | — | — | — |  |
| 2026-04-18 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24597877527) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24598073311) [2] | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24598121074) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24598096412) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24598099329) |  |
| 2026-04-16 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24497568304) | [<span style="color:red">fail</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24527494181) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24497288926) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24498382832) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/24498495818) | cxl/fixes build timeout issue. Passed on rerun. |

<div id="pagination-controls" style="margin: 20px 0; text-align: center; display: flex; justify-content: center; align-items: center;">
  <button id="prev-btn" style="padding: 5px 10px; margin: 0 5px; cursor: pointer; font-size: 0.85em;">← prev</button>
  <span id="page-info" style="margin: 0 10px; font-size: 0.9em;"></span>
  <button id="next-btn" style="padding: 5px 10px; margin: 0 5px; cursor: pointer; font-size: 0.85em;">next →</button>
</div>

</div>

<script>
(function() {
  const ROWS_PER_PAGE = 30;
  const HEADER_ROWS = 3;  // Date header, separator, Test Scope row
  let currentPage = 1;
  let allRows = [];
  
  function init() {
    console.log('Pagination init starting...');
    
    const container = document.getElementById('results-table-container');
    console.log('Container found:', !!container);
    if (!container) return;
    
    const table = container.querySelector('table');
    console.log('Table found:', !!table);
    if (!table) return;
    
    // Get all rows from table (not just tbody)
    const rows = Array.from(table.querySelectorAll('tr'));
    console.log('Total rows in table:', rows.length);
    allRows = rows.slice(HEADER_ROWS);
    console.log('Data rows (after skipping headers):', allRows.length);
    console.log('ROWS_PER_PAGE:', ROWS_PER_PAGE);
    console.log('Should show pagination?', allRows.length > ROWS_PER_PAGE);
    
    if (allRows.length <= ROWS_PER_PAGE) {
      // Hide pagination if not needed
      console.log('Hiding pagination - not enough rows');
      document.getElementById('pagination-controls').style.display = 'none';
      return;
    }
    
    console.log('Setting up pagination...');
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
