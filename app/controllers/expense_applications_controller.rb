class ExpenseApplicationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @expense_application = ExpenseApplication.new
  end

  def create
    @expense_application = current_user.expense_applications.build(expense_application_params)
    if @expense_application.save
      redirect_to root_path, notice: "経費申請を送信しました"
    else
      render :new
    end
  end

  private

  def expense_application_params
    params.require(:expense_application).permit(:date, :amount, :purpose)
  end
end
