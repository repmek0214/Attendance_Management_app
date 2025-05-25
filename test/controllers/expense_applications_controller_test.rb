require "test_helper"

class ExpenseApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get expense_applications_new_url
    assert_response :success
  end

  test "should get create" do
    get expense_applications_create_url
    assert_response :success
  end
end
