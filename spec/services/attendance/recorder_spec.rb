require 'rails_helper' # Railsのテストヘルパーを読み込み
require_relative '../../../app/services/attendance/recorder' # AttendanceService::Recorderをロード

RSpec.describe AttendanceService::Recorder, type: :service do # モジュール名を変更
  let(:user) { create(:user) } # テスト用のユーザーを作成

  describe '.call' do
    context '正常系' do
      it '出勤打刻を新規作成する' do
        expect {
          described_class.call(user: user, action: :clock_in, timestamp: Time.zone.local(2025,5,31,9,0)) # 出勤打刻を呼び出し、指定した日時で新規作成
        }.to change { Attendance.count }.by(1) # Attendanceレコードが1件増えることを確認
      end

      it '退勤打刻を既存レコードに追記する' do
        described_class.call(user: user, action: :clock_in) # まず出勤打刻を作成
        expect {
          described_class.call(user: user, action: :clock_out) # 退勤打刻を呼び出し、既存の出勤レコードに追記
        }.to change { user.attendances.first.reload.clock_out }.from(nil) # clock_outがnilから更新されることを確認
      end
    end

    context '異常系' do
      it '二重出勤は例外' do
        described_class.call(user: user, action: :clock_in) # 最初の出勤打刻を作成
        expect {
          described_class.call(user: user, action: :clock_in) # 再度出勤打刻を呼び出し、例外が発生することを確認
        }.to raise_error(AttendanceService::Recorder::AlreadyClockedInError) # 二重出勤例外が発生することを確認
      end

      it '出勤なし退勤は例外' do
        expect {
          described_class.call(user: user, action: :clock_out) # 出勤打刻なしで退勤打刻を呼び出し、例外が発生することを確認
        }.to raise_error(AttendanceService::Recorder::NeverClockedInError) # 出勤なし退勤例外が発生することを確認
      end
    end
  end
end