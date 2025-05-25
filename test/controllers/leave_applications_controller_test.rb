require "test_helper"

class LeaveApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get leave_applications_new_url
    assert_response :success
  end

  test "should get create" do
    get leave_applications_create_url
    assert_response :success
  end
end
