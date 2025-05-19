class Admin::ShiftRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @requests = ShiftRequest.includes(:user).order(shift_date: :desc)
  end

  def update
    req = ShiftRequest.find(params[:id])
    if req.update(status: params[:status])
      redirect_to admin_shift_requests_path, notice: 'ステータスを更新しました'
    else
      redirect_to admin_shift_requests_path, alert: '更新に失敗しました'
    end
  end

  private

  def require_admin!
    redirect_to root_path, alert: '権限がありません' unless current_user.admin?
  end
end