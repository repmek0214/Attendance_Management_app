class LeaveApplication < ApplicationRecord
  belongs_to :user

  validates :start_date, :end_date, :reason, presence: true

  enum status: { pending: 0, approved: 1, rejected: 2 }
end
