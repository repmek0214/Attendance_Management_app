require 'simplecov' # カバレッジ計測ツールSimpleCovを読み込む

SimpleCov.start 'rails' do
  add_filter 'bin/'    # binディレクトリをカバレッジ対象から除外
  add_filter 'config/' # configディレクトリをカバレッジ対象から除外
  add_filter 'db/'     # dbディレクトリをカバレッジ対象から除外
end

RSpec.configure do |config| # RSpecの設定ブロック

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    # カスタムマッチャの説明や失敗メッセージにchainメソッドの内容も含める
  end
  
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    # 存在しないメソッドのスタブやモックを禁止する
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  # shared_contextのメタデータをホストグループやexampleに適用する

end
