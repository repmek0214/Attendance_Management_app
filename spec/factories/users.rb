FactoryBot.define do
  factory :user do
    # sequence(:email)で一意のメールアドレスを生成
    sequence(:email) { |n| "user#{n}@example.com" }
    # password属性にデフォルト値を設定
    password { 'password' }
    # role属性にデフォルト値として従業員を設定
    role { :employee }
  end
end