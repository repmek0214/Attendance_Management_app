class LeaveApplicationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @leave_application = LeaveApplication.new
  end

  def create
    @leave_application = current_user.leave_applications.build(leave_application_params)
    if @leave_application.save
      redirect_to root_path, notice: "休暇申請を送信しました"
    else
      render :new
    end
  end

  def index
    @leave_applications = current_user.leave_applications.order(created_at: :desc)
  end

  private

  def leave_application_params
    params.require(:leave_application).permit(:start_date, :end_date, :reason)
  end
end
