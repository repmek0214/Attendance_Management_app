require 'rails_helper'

RSpec.describe AttendanceCorrection, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:reason) }

  describe 'enum statusのテスト' do
    it { is_expected.to define_enum_for(:status).with_values(pending:0, approved:1, rejected:2) }
  end

  describe 'apply_correctionコールバックのテスト' do
    let(:user) { create(:user) }

    it '初回承認時にAttendanceが作成されることをテスト' do
      correction = create(:attendance_correction, user: user, status: :pending)
      expect {
        correction.update!(status: :approved)
      }.to change { Attendance.count }.by(1)
      attendance = Attendance.last
      expect(attendance.date).to eq correction.date
      expect(attendance.clock_in).to eq correction.corrected_in
      expect(attendance.clock_out).to eq correction.corrected_out
    end

    it '再承認時に既存のAttendanceが更新されることをテスト' do
      attendance = create(:attendance, user: user, date: Date.current, clock_in: 9.hours.ago, clock_out: 5.hours.ago)
      correction = create(:attendance_correction, user: user, date: Date.current, status: :pending,
                                         corrected_in: 11.hours.ago, corrected_out: 4.hours.ago)
      correction.update!(status: :approved)
      attendance.reload
      expect(attendance.clock_in.to_i).to eq(correction.corrected_in.to_i)
      expect(attendance.clock_out.to_i).to eq(correction.corrected_out.to_i)
    end
  end
end