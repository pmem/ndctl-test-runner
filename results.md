# NDCTL Test Runner

## Mainline Tag Results

All Unit Tests are run against Linus mainline release tags (vX.Y, vX.Y-rcN) using the [ndctl pending branch](https://github.com/pmem/ndctl/tree/pending). Each tag is tested once and may be rerun if needed. The table shows the latest result for each tag. Click pass/fail results to view logs and details (links are retained for 30 days).
- <span style="color:green">pass</span> = all tests passed (pass [N] means N tests were skipped)
- <span style="color:red">fail</span> = one or more failures occurred (test failure, build failure, or workflow/infrastructure failure)

| Kernel Tag | Date Tagged | Date Tested | Result | Attempts | Notes |
|------------|-------------|-------------|--------|----------|-------|
| v7.1 | 2026-06-14 | 2026-06-15 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27573852969) | 1 |  |
| v7.1-rc7 | 2026-06-07 | 2026-06-08 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27144818896) | 1 |  |
| v7.1-rc6 | 2026-05-31 | 2026-06-01 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26767313370) | 1 |  |
| v7.1-rc5 | 2026-05-24 | 2026-05-25 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26403585961) | 1 |  |
| v7.1-rc4 | 2026-05-17 | 2026-05-18 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26038371655) | 1 |  |
| v7.1-rc3 | 2026-05-10 | 2026-05-11 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25672722173) | 1 |  |
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
| 2026-06-22 | — | — | — | — | — |  |
| 2026-06-21 | — | — | — | — | — |  |
| 2026-06-20 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27864520263) |  |
| 2026-06-19 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27815885324) |  |
| 2026-06-18 | — | — | — | — | — |  |
| 2026-06-17 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27677266901) |  |
| 2026-06-16 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27607107655) |  |
| 2026-06-15 | — | — | — | — | — |  |
| 2026-06-14 | — | — | — | — | — |  |
| 2026-06-13 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27459194897) | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27460550241) |  |
| 2026-06-12 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27403501332) |  |
| 2026-06-11 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27330195504) | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27333929613) |  |
| 2026-06-10 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27258400633) | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27261843802) |  |
| 2026-06-09 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27191093219) |  |
| 2026-06-08 | — | — | — | — | — |  |
| 2026-06-07 | — | — | — | — | — |  |
| 2026-06-06 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27055315036) |  |
| 2026-06-05 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26999954182) | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/27002895626) |  |
| 2026-06-04 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26939366068) |  |
| 2026-06-03 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26869694859) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26869637052) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26872870554) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26872881945) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26873780836) |  |
| 2026-06-02 | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26806753932) | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26807399522) |  |
| 2026-06-01 | — | — | — | — | — |  |
| 2026-05-31 | — | — | — | — | — |  |
| 2026-05-30 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26676264768) | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26677074034) |  |
| 2026-05-29 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26622175533) | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26624886318) |  |
| 2026-05-28 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26561728079) |  |
| 2026-05-27 | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26495278088) | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26498373027) |  |
| 2026-05-25 | — | — | — | — | — |  |
| 2026-05-24 | — | — | — | — | — |  |
| 2026-05-23 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26325734734) |  |
| 2026-05-22 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26272210334) | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26274726335) |  |
| 2026-05-21 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26212404930) |  |
| 2026-05-20 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26145540758) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26145530130) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26146580460) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26146583556) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26148225653) |  |
| 2026-05-19 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/26083062048) |  |
| 2026-05-18 | — | — | — | — | — |  |
| 2026-05-17 | — | — | — | — | — |  |
| 2026-05-16 | — | — | — | — | — |  |
| 2026-05-15 | — | — | — | — | — |  |
| 2026-05-14 | — | — | — | — | — |  |
| 2026-05-13 | — | — | — | — | — |  |
| 2026-05-12 | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25716061910) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25716046263) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25717207199) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25717215091) | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25717601830) |  |
| 2026-05-11 | — | — | — | — | — |  |
| 2026-05-10 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25621805550) |  |
| 2026-05-09 | — | — | — | — | [<span style="color:red">fail</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25593714112) |  |
| 2026-05-08 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25539331276) |  |
| 2026-05-07 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25479736528) |  |
| 2026-05-06 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25419834190) |  |
| 2026-05-05 | — | — | — | — | [<span style="color:green">pass</span>](https://github.com/pmem/ndctl-test-runner/actions/runs/25356936167) |  |
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
