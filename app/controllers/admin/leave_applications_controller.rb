class Admin::LeaveApplicationsController < ApplicationController
  def index
    @leave_applications = LeaveApplication.order(created_at: :desc)
  end

  def update
    @leave_application = LeaveApplication.find(params[:id])
    @leave_application.update(status: params[:status])
    redirect_to admin_leave_applications_path, notice: "申請を更新しました"
  end
end
