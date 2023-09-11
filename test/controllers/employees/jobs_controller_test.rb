require "test_helper"

class Employees::JobsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employees_jobs_index_url
    assert_response :success
  end
end
