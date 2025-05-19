class ShiftRequestsController < ApplicationController
  before_action :authenticate_user!

  def monthly_new
    # パラメータがなければ今の年・月を使う
    @year  = params[:year].present?  ? params[:year].to_i  : Date.current.year
    @month = params[:month].present? ? params[:month].to_i : Date.current.month

    @start_date = Date.new(@year, @month, 1)
    @end_date   = @start_date.end_of_month
  end

  def monthly_create
    # フォームから来る "HH:MM" 形式の文字列をパース
    common_start = Time.zone.parse(params[:common_start_time])
    common_end   = Time.zone.parse(params[:common_end_time])

    dates = Array(params[:shift_dates]).map(&:to_date)

    ShiftRequest.transaction do
      dates.each do |date|
        # 日付を common_start/common_end の時刻部分にセット
        start_at = common_start.change(year: date.year, month: date.month, day: date.day)
        end_at   = common_end.change(  year: date.year, month: date.month, day: date.day)

        current_user.shift_requests.create!(
          shift_date:  date,
          start_time:  start_at,
          end_time:    end_at,
          status:      :pending
        )
      end
    end

    redirect_to root_path, notice: "#{dates.size} 件のシフト希望を提出しました"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to monthly_new_shift_requests_path(year: @year, month: @month),
                alert: "提出エラー: #{e.record.errors.full_messages.join(', ')}"
  end

  def index
    @requests = current_user.shift_requests.order(shift_date: :asc)
  end# 省略: index, etc.

end