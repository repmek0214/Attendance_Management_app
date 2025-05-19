class HomeController < ApplicationController

  before_action :authenticate_user!

  def index
    month_range = Date.current.beginning_of_month..Date.current.end_of_month
    @schedules = current_user.schedules.where(date: month_range)
    @today_attendance = current_user.attendances.find_by(date: Date.current)
  end
end
