require 'spec_helper' # RSpecの基本設定ファイルを読み込む
ENV['RAILS_ENV'] ||= 'test' # RAILS_ENVが未設定なら'test'をセット
require_relative '../config/environment' # Railsアプリの環境設定を読み込む

abort("The Rails environment is running in production mode!") if Rails.env.production?
# 本番環境でテストが実行されるのを防ぐ

require 'rspec/rails' # RSpecのRails用拡張を読み込む

begin
  ActiveRecord::Migration.maintain_test_schema! # テスト用DBのマイグレーション状態を維持
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip # 未実行マイグレーションがあればエラー表示
  exit 1 # 異常終了
end

RSpec.configure do |config| # RSpecの設定ブロック
  config.fixture_path = "#{::Rails.root}/spec/fixtures" # fixtureのパスを指定
  config.include FactoryBot::Syntax::Methods # FactoryBotのメソッドを直接使えるようにする

  config.use_transactional_fixtures = false # トランザクションによるテストデータのロールバックを無効化（DatabaseCleanerを使うため）

  config.infer_spec_type_from_file_location! # specファイルの場所から自動的にテストタイプを推測
  config.filter_rails_from_backtrace! # バックトレースからRailsのフレームワーク部分を除外

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation) # テストスイート開始前にDB全体を削除
  end

  config.before(:each) do |example|
    # js: true の場合はtruncation、それ以外はtransactionでDBをクリーニング
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start # 各テスト前にクリーニング開始
  end

  config.append_after(:each) do
    DatabaseCleaner.clean # 各テスト後にDBをクリーニング
  end

  # BulletのRSpecフック
  if defined?(Bullet) && Bullet.enable?
    config.before(:each) { Bullet.start_request } # 各テスト前にBulletを開始
    config.after(:each)  { Bullet.perform_out_of_channel_notifications if Bullet.notification? } # 通知があれば出力
    config.after(:each)  { Bullet.end_request } # 各テスト後にBulletを終了
  end
end

Shoulda::Matchers.configure do |config| # shoulda-matchersの設定
  config.integrate do |with|
    with.test_framework :rspec # RSpecと統合
    with.library :rails # Rails用マッチャを有効化
  end
end