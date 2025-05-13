FactoryBot.define do
    factory :attendance_correction do
      user
      date { Date.current }
      corrected_in  { DateTime.current.change(hour: 10, min: 0) }
      corrected_out { DateTime.current.change(hour: 19, min: 0) }
      reason { "テスト修正" }
      status { :pending }
    end
  end