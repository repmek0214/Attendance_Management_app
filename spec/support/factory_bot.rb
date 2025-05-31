RSpec.configure do |config|
  config.before(:suite) { FactoryBot.find_definitions } # FactoryBotの定義を読み込む
end