require 'rails_helper'

RSpec.describe Attendance, type: :model do
  # date属性が必須であることを検証
  it { is_expected.to validate_presence_of(:date) }
  # AttendanceモデルがUserモデルに属していることを検証
  it { is_expected.to belong_to(:user) }

  context '一意制約' do
    # 既存のAttendanceレコードを作成
    let!(:existing) { create(:attendance, user: user, date: "2025-05-30") }
    # Userレコードを作成
    let(:user) { create(:user) }

    it '同じユーザ・日付は無効' do
      # 同じユーザと日付でAttendanceを作成しようとする
      duplicate_attendance = build(:attendance, user: user, date: "2025-05-30")
      # 一意制約により無効であることを期待
      expect(duplicate_attendance).to be_invalid
    end
  end
end