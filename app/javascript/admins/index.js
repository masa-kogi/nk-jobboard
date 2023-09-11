function debounce(func, wait = 300) {
  let timeout;
  return function (...args) {
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(this, args), wait);
  };
}

window.onload = function () {
  let adminUsername = document.body.dataset.adminUsername;
  let csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');
  let selectedDepartment = null;

  let statusSelect = document.querySelector('#job-status-filter-form select[name="status"]');

  document.querySelectorAll('.department-link').forEach(function (link) {
    link.addEventListener('click', function (e) {
      e.preventDefault();
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

  document.querySelectorAll('.page a').forEach(function (link) {
    link.addEventListener('click', function (e) {
      e.preventDefault();

      // href属性からpageの値を取得
      const pageMatch = e.currentTarget.href.match(/page=(\d+)/);
      if (pageMatch) {
        const page = pageMatch[1];
        loadJobs(page); // ページ番号をloadJobs関数に渡す
      }
    });
  });

  function loadJobs(page) {
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

    if (page) {
      params.append('page', page); // ページ番号をパラメータに追加
    }

    let queryParams = `/admins/${adminUsername}/jobs?${params.toString()}`;

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
