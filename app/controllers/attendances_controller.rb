class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @attendances = current_user.attendances
                               .order(date: :desc)
                               .where(date: filtering_date_range)
    @today_attendance = current_user.attendances.find_by(date: Date.current)
  end
  

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

  private

  def filtering_date_range
    if params[:month].present?
      begin
        month = Date.parse(params[:month] + "-01")
        month.beginning_of_month..month.end_of_month
      rescue Date::Error
        flash.now[:alert] = "無効な日付形式です。正しい形式（YYYY-MM）で入力してください。"
        Date.current..Date.current # デフォルトの範囲を返す
      end
    else
      Date.current..Date.current
    end
  end

end
