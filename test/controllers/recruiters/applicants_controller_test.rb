require "test_helper"

class Recruiters::ApplicantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recruiters_applicants_index_url
    assert_response :success
  end

  test "should get show" do
    get recruiters_applicants_show_url
    assert_response :success
  end
end
