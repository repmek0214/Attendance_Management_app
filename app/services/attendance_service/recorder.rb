# frozen_string_literal: true # 文字列リテラルを変更不可にする

module AttendanceService 
  class Recorder
    # ==== Public API ==================================================
    # @param user [User] 打刻対象ユーザ
    # @param action [:clock_in, :clock_out] どちらの打刻か
    # @param timestamp [Time] 実際の打刻時刻 (Time.zone.now を推奨)
    # @return [::Attendance] 保存後のモデル
    # @raise  [ActiveRecord::RecordInvalid] バリデーション失敗時
    # @raise  [StandardError] その他予期しないエラー
    # ================================================================
    def self.call(user:, action:, timestamp: Time.zone.now) # クラスメソッドの定義
      new(user, action, timestamp).call # インスタンスを生成して処理を実行
    end

    # ---------------------------------------------------------------
    def initialize(user, action, timestamp) # 初期化メソッド
      @user      = user # ユーザーを設定
      @action    = action.to_sym # アクションをシンボルに変換して設定
      @timestamp = timestamp # タイムスタンプを設定
      validate_action! # アクションの妥当性を検証
    end

    # ==== メイン処理（トランザクションあり） =========================
    def call # メイン処理を実行
      ActiveRecord::Base.transaction do # トランザクションを開始
        record = find_or_initialize_attendance! # 出勤記録を検索または初期化
        case @action # アクションに応じた処理を実行
        when :clock_in  then apply_clock_in!(record) # 出勤処理を適用
        when :clock_out then apply_clock_out!(record) # 退勤処理を適用
        end
        record.save! # レコードを保存
        record # 保存したレコードを返す
      end
    end

    # ---------------------------------------------------------------
    private # 以下はプライベートメソッド

    def validate_action! # アクションの妥当性を検証
      return if %i[clock_in clock_out].include?(@action) # 許可されたアクションか確認
      raise ArgumentError, "Unsupported action: #{@action}" # 許可されていない場合は例外を発生
    end

    def find_or_initialize_attendance! # 出勤記録を検索または初期化
      @user.attendances.where(date: @timestamp.to_date).first_or_initialize # 日付で検索し、なければ初期化
    end

    def apply_clock_in!(record) # 出勤処理を適用
      raise AlreadyClockedInError,  record if record.clock_in.present? # 既に出勤済みの場合は例外を発生
      record.clock_in  = @timestamp # 出勤時刻を設定
      record.clock_out = nil # 退勤時刻をリセット
    end

    def apply_clock_out!(record) # 退勤処理を適用
      raise NeverClockedInError,    record if record.clock_in.blank? # 出勤記録がない場合は例外を発生
      raise AlreadyClockedOutError, record if record.clock_out.present? # 既に退勤済みの場合は例外を発生
      record.clock_out = @timestamp # 退勤時刻を設定
    end

    # ==== カスタム例外 ==============================================
    class AlreadyClockedInError  < StandardError; end # 二重出勤例外
    class AlreadyClockedOutError < StandardError; end # 二重退勤例外
    class NeverClockedInError    < StandardError; end # 出勤なし退勤例外
  end
end