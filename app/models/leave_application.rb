class LeaveApplication < ApplicationRecord
  belongs_to :user

  validates :start_date, :end_date, :reason, presence: true

  enum status: { pending: 0, approved: 1, rejected: 2 }
  
  def status_i18n
    I18n.t("activerecord.attributes.leave_application.status.#{status}")
  end
end
