source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'config'
gem 'font-awesome-sass'

# Active Storage関連
gem 'active_storage_validations'
gem 'aws-sdk-s3'
gem 'image_processing', '~> 1.2'
gem 'mini_magick'

# 認証機能関連
gem 'sorcery'

# CSSフレームワーク
gem 'bulma-rails'

# 国際化対応
gem 'rails-i18n'

# 管理機能関連
gem 'rails_admin', '~> 2.0'
gem 'rails_admin-i18n'

# 認可機能関連
gem 'cancancan'

# Google Map関連
gem 'dotenv-rails' # APIキー等を隠す。
gem 'geocoder' # 住所から緯度経度を算出する。

gem 'pry-rails'
gem 'pry-byebug'

group :development, :test do
  # Debugger
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'better_errors'
  gem 'binding_of_caller'

  # Code analyze
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rails_best_practices'

  # テスト
  gem 'rspec-rails'
  gem 'factory_bot_rails'

  # メール送信テスト用
  gem 'letter_opener_web', '~> 1.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
