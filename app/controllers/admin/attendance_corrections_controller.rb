class Admin::AttendanceCorrectionsController < Admin::BaseController
  def index
    @corrections = AttendanceCorrection.order(created_at: :desc).includes(:user)
  end

  def update
    @correction = AttendanceCorrection.find(params[:id])
    @correction.update(status: params[:status])
    redirect_to admin_attendance_corrections_path, notice: "勤怠修正申請を更新しました"
  end
end