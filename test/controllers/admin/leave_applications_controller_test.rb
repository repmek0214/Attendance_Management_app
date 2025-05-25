require "test_helper"

class Admin::LeaveApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_leave_applications_index_url
    assert_response :success
  end

  test "should get update" do
    get admin_leave_applications_update_url
    assert_response :success
  end
end
