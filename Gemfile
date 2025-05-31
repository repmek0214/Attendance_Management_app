source "https://rubygems.org"

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.5", ">= 7.1.5.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

group :production do
  gem 'pg', '~> 1.5'
end

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 6.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  gem 'rspec-rails', '~> 6.1'       # RSpec本体
  gem 'factory_bot_rails'
  gem 'faker', '~> 3.2'            # テストデータ生成用
  gem 'fuubar'
  gem 'rubocop', require: false # コード品質チェック
  gem 'rubocop-rails', require: false 
  gem 'rubocop-rspec', require: false         
  gem 'shoulda-matchers', '~> 6.0'
  gem 'sqlite3', '~> 1.5'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  gem 'bullet'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'simplecov', require: false
  gem 'database_cleaner-active_record'
end

gem 'haml-rails', '~> 2.0'
gem 'html2haml', '~> 2.2'
gem 'bootstrap', '~> 5.3.0'
gem 'sassc-rails'
gem 'devise'
gem 'rails_admin', '~> 3.0'
gem 'cancancan', '~> 3.3', require: 'cancan'
gem "cssbundling-rails"
gem 'chartkick'
gem 'groupdate'
gem 'pagy'
gem 'rails-i18n'
gem 'devise-i18n-views'
gem "simple_calendar", "~> 3.1"
