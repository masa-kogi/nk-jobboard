$(document).on('change', '#job_department_id', function () {
  const departmentId = $(this).val();
  console.log("Selected department ID: ", departmentId);  // Debugging line

  const url = $('form').data('url');
  console.log("URL: ", url);  // Debugging line to check the URL

  if (departmentId) {
    $.getJSON(url, { department_id: departmentId }, function (data) {
      console.log("Received data: ", data);  // Debugging line
      const selectBox = $('#job_contact_person_ids');
      selectBox.empty();
      data.forEach(function (recruiter) {
        selectBox.append(new Option(recruiter.name, recruiter.id));
      });
    });
  } else {
    $('#job_contact_person_ids').empty();
  }
});
