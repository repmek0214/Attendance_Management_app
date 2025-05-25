FactoryBot.define do
  factory :shift_request do
    user { nil }
    shift_date { "2025-05-19" }
    start_time { "2025-05-19 18:57:15" }
    end_time { "2025-05-19 18:57:15" }
    reason { "MyString" }
    status { 1 }
  end
end
