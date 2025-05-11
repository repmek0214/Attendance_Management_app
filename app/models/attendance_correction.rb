class AttendanceCorrection < ApplicationRecord
  belongs_to :user

  validates :date, :reason, presence: true

  enum status: { pending: 0, approved: 1, rejected: 2 }

  after_update :apply_correction, if: -> { saved_change_to_status? && approved? }

  def status_i18n
    I18n.t("activerecord.attributes.attendance_correction.status.#{status}")
  end

  private

  def apply_correction
    attendance = user.attendances.find_or_initialize_by(date: date)
    attendance.clock_in  = corrected_in  if corrected_in.present?
    attendance.clock_out = corrected_out if corrected_out.present?
    attendance.save!
  end

end

