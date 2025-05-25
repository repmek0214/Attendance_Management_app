class ExpenseApplication < ApplicationRecord
  belongs_to :user

  validates :date, :amount, :purpose, presence: true
  validates :amount, numericality: { greater_than: 0 }

  enum status: { pending: 0, approved: 1, rejected: 2 }

  def status_i18n
    I18n.t("activerecord.attributes.leave_application.status.#{status}")
  end
end