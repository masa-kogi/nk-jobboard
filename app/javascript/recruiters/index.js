function debounce(func, wait = 300) {
  let timeout;
  return function (...args) {
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(this, args), wait);
  };
}

window.onload = function () {
  let recruiterUsername = document.body.dataset.recruiterUsername;
  let csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');
  let selectedDepartment = null;
  let statusSelect = document.querySelector('#job-status-filter-form select[name="status"]');

  document.querySelectorAll('.department-link').forEach(link => {
    link.addEventListener('click', function (e) {
      e.preventDefault();

      // ここでクリックされたリンクの部門名を取得
      let clickedDepartmentName = e.currentTarget.dataset.departmentName;
      let clickedDepartmentId = e.currentTarget.dataset.departmentId;

      // DOMに部門名をセット
      document.querySelector('p.pb-3').textContent = clickedDepartmentName;

      // 隠しフィールドに部門IDをセット
      document.querySelector('#job-status-filter-form input[name="department"]').value = clickedDepartmentId;

      selectedDepartment = e.currentTarget.dataset.departmentId;
      loadJobs();
    });
  });

  document.querySelector('#job-status-filter-form').addEventListener('change', function () {
    loadJobs();
  });

  document.querySelector('#search-form input[type="search"]').addEventListener('input', debounce(function () {
    loadJobs();
  }));

  document.querySelectorAll('a[data-remote="true"]').forEach(link => {
    link.addEventListener('click', function (e) {
      e.preventDefault();
      // e.stopPropagation(); // これを追加

      // ここでクリックされたリンクのhref属性からpageパラメータを抽出
      let url = new URL(e.currentTarget.href);
      let page = url.searchParams.get('page');

      // 取得したpage値をloadJobs関数に渡す
      loadJobs(page);
    });
  });

  function loadJobs(page = 1) {
    let selectedStatus = statusSelect.value;
    let searchQuery = document.querySelector('#search-form input[type="search"]').value;

    let params = new URLSearchParams({
      status: selectedStatus,
      'q[global_search_cont]': searchQuery,
    });

    if (selectedDepartment !== null && selectedDepartment !== 'undefined') {
      params.append('department', selectedDepartment);
    }

    let departmentValue = document.querySelector('#job-status-filter-form input[name="department"]').value;

    if (departmentValue) {
      params.append('department', departmentValue);
    }

    let currentPage = page || new URLSearchParams(window.location.search).get('page') || 1;
    params.append('page', currentPage);

    let queryParams = `/recruiters/${recruiterUsername}/jobs?${params.toString()}`;

    fetch(queryParams, {
      headers: {
        'Accept': 'text/javascript',
        'X-CSRF-Token': csrfToken
      },
    }).then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.text(); // または .json() などの適切なメソッド
    }).then(data => {
      eval(data);
    }).catch(error => {
      console.error('Fetch error:', error);
    });
  }
};
