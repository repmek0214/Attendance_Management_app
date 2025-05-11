require "test_helper"

class Admin::AttendanceCorrectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_attendance_corrections_index_url
    assert_response :success
  end

  test "should get update" do
    get admin_attendance_corrections_update_url
    assert_response :success
  end
end
