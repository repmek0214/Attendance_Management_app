require "test_helper"

class AttendanceCorrectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get attendance_corrections_new_url
    assert_response :success
  end

  test "should get create" do
    get attendance_corrections_create_url
    assert_response :success
  end

  test "should get index" do
    get attendance_corrections_index_url
    assert_response :success
  end
end
