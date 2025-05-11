class Admin::ExpenseApplicationsController < ApplicationController
  def index
    @expense_applications = ExpenseApplication.order(created_at: :desc)
  end

  def update
    @expense_application = ExpenseApplication.find(params[:id])
    @expense_application.update(status: params[:status])
    redirect_to admin_expense_applications_path, notice: "申請を更新しました"
  end
end
