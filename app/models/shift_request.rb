class ShiftRequest < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :shift_date,
            presence: true,
            uniqueness: { scope: :user_id, message: "には既に申請があります" }

  after_update :apply_to_schedule, if: -> { saved_change_to_status? && approved? }

  # 追加：ステータスの日本語翻訳を返す
  def status_i18n
    I18n.t("activerecord.enums.shift_request.status.#{status}")
  end

  private

  def apply_to_schedule
    Schedule.create!(
      user:       user,
      date:       shift_date,
      start_time: start_time,
      end_time:   end_time,
    )
  end
end