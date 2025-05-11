class AttendanceCorrectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @corrections = current_user.attendance_corrections.order(created_at: :desc)
  end

  def new
    @correction = AttendanceCorrection.new
  end

  def create
    @correction = current_user.attendance_corrections.build(correction_params)
    if @correction.save
      redirect_to attendance_corrections_path, notice: "勤怠修正申請を送信しました"
    else
      render :new
    end
  end

  private

  def correction_params
    params.require(:attendance_correction)
          .permit(:date, :corrected_in, :corrected_out, :reason)
  end
end