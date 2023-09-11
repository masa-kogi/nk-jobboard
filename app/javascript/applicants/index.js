function debounce(func, wait = 300) {
  let timeout;
  return function (...args) {
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(this, args), wait);
  };
}

window.onload = function () {
  let csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');
  // let selectedDepartment = null;

  let statusSelect = document.querySelector('#application-status-filter-form select[name="status"]');

  document.querySelector('#application-status-filter-form').addEventListener('change', function () {
    loadApplicants();
  });

  document.querySelector('#search-form input[type="search"]').addEventListener('input', debounce(function () {
    loadApplicants();
  }));

  document.querySelectorAll('.page a').forEach(function (link) {
    link.addEventListener('click', function (e) {
      e.preventDefault();

      // href属性からpageの値を取得
      const pageMatch = e.currentTarget.href.match(/page=(\d+)/);
      if (pageMatch) {
        const page = pageMatch[1];
        loadApplicants(page); // ページ番号をloadJobs関数に渡す
      }
    });
  });


  function loadApplicants(page) {
    let jobId = document.body.getAttribute('data-job-id'); // ここでjob_idを取得
    let selectedStatus = statusSelect.value;
    let searchQuery = document.querySelector('#search-form input[type="search"]').value;

    let params = new URLSearchParams({
      status: selectedStatus,
      'q[global_search_cont]': searchQuery,
    });

    if (page) {
      params.append('page', page); // ページ番号をパラメータに追加
    }

    let queryParams = `/jobs/${jobId}/applicants?${params.toString()}`; // ここでURLを修正

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
      console.log(data);
      eval(data);
    }).catch(error => {
      console.error('Fetch error:', error);
    });
  }
};
