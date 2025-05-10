class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    date = Date.current
    attendance = current_user.attendances.find_or_initialize_by(date: date)

    if attendance.clock_in.nil?
      attendance.clock_in = Time.current
      message = "出勤打刻しました"
    elsif attendance.clock_out.nil?
      attendance.clock_out = Time.current
      message = "退勤打刻しました"
    else
      message = "本日の打刻は完了済みです"
    end

    attendance.save!
    redirect_to root_path, notice: message
  end    
end
