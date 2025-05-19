class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { employee: 0, admin: 1 }

  has_many :attendances, dependent: :destroy
  has_many :leave_applications, dependent: :destroy
  has_many :expense_applications, dependent: :destroy
  has_many :attendance_corrections, dependent: :destroy
  has_many :shift_requests, dependent: :destroy
  has_many :schedules,      dependent: :destroy

end