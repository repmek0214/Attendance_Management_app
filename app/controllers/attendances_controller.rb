class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @attendances = current_user.attendances
                               .order(date: :desc)
                               .where(date: filtering_date_range)
  end
  

  def create
    # アクションタイプをマッピングするハッシュを定義
    action_map = {
      'in' => :clock_in, # "in"は出勤打刻
      'out' => :clock_out # "out"は退勤打刻
    }

    # パラメータからアクションタイプを取得
    action_type = params[:action_type]
    # アクションタイプをマッピングから取得
    action = action_map[action_type]

    # アクションタイプが無効な場合は例外を発生
    raise ArgumentError, "Unknown action_type: #{action_type}" if action.nil?

    # 打刻時刻のパラメータを取得（出勤か退勤によって異なる）
    timestamp_param = action == :clock_in ? params[:clock_in] : params[:clock_out]
    # 打刻時刻を解析し、デフォルトで現在時刻を使用
    timestamp = Time.zone.parse(timestamp_param.presence || Time.zone.now.to_s)

    # AttendanceService::Recorderを呼び出して打刻処理を実行
    AttendanceService::Recorder.call(
      user: current_user, # 現在のユーザーを指定
      action: action, # アクションを指定（出勤または退勤）
      timestamp: timestamp # 打刻時刻を指定
    )
    # 処理成功時にリダイレクト
    redirect_to root_path, notice: '打刻しました'
  rescue AttendanceService::Recorder::AlreadyClockedInError
    redirect_back fallback_location: root_path, alert: '既に出勤済みです'
  rescue AttendanceService::Recorder::NeverClockedInError
    redirect_back fallback_location: root_path, alert: '出勤打刻がありません'
  rescue ActiveRecord::RecordInvalid
    redirect_back fallback_location: root_path, alert: '保存に失敗しました'
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
