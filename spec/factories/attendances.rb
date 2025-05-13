FactoryBot.define do
    factory :attendance do
      user
      date { Date.today }
      clock_in { Time.current.change(hour: 9) }
      clock_out { Time.current.change(hour: 18) }
    end
  end