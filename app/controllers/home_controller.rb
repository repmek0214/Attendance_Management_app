class HomeController < ApplicationController
  def index
    month_range = Date.current.beginning_of_month..Date.current.end_of_month
    @schedules = current_user.schedules.where(date: month_range)
  end
end
