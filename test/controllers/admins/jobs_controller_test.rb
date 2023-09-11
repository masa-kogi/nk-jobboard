require "test_helper"

class Admins::JobsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_jobs_index_url
    assert_response :success
  end
end
