class Admin::DashboardController < Admin::BaseController
  def index
    @leave_by_month = LeaveApplication.group_by_month(:created_at, format: "%Y年%m月").count
    @expense_by_month = ExpenseApplication.group_by_month(:created_at, format: "%Y年%m月").count

    @leave_by_status = LeaveApplication.group(:status).count
    @expense_by_status = ExpenseApplication.group(:status).count
  end
end
