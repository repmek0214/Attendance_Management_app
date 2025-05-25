require "test_helper"

class Admin::ExpenseApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_expense_applications_index_url
    assert_response :success
  end

  test "should get update" do
    get admin_expense_applications_update_url
    assert_response :success
  end
end
