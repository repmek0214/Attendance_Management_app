class AttendanceCorrection < ApplicationRecord
  belongs_to :user

  validates :date, :reason, presence: true

  enum status: { pending: 0, approved: 1, rejected: 2 }

  def status_i18n
    I18n.t("activerecord.attributes.attendance_correction.statuses.#{status}")
  end
end

