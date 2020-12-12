# frozen_string_literal: true
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'

# Use pg as the database for Active Record
gem 'pg', '~> 1.1'

# Use Puma as the app server
gem 'puma', '~> 5.0'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Rails engine for cache-friendly, client-side local time
gem 'local_time', '~> 2.0'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Generate short unique id's
gem 'nanoid'

# Handle authentication
gem 'rodauth', '~> 2.6'
gem 'rodauth-rails', '~> 0.7'
gem 'jwt', require: false # for JWT feature
gem 'rotp', require: false # for OTP feature
gem 'rqrcode', require: false # for OTP feature
gem 'webauthn', require: false # for WebAuthn feature
gem 'view_component', require: 'view_component/engine'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'break'
  gem 'spring'

  # Code critics
  gem 'reek', '>= 6.0.2', require: false
  gem 'rubocop', '>= 0.72', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-shopify', require: false
  gem 'erb_lint', require: false, github: 'cj/erb-lint'
  gem 'better_html', '~> 1.0.7'
  gem 'ruumba'
  gem 'scss_lint', '~> 0.50', require: false
  gem 'bundler-audit',
    '~> 0.4',
      github: 'basecamp/bundler-audit',
      branch: 'thor-bump',
      require: false
  gem 'brakeman', '>= 4.0', require: false
  gem 'benchmark-ips', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'

  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'faker', require: false

  # Handle live reloading
  gem 'guard'
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'rack-livereload'
  gem 'guard-rails', github: 'atd/guard-rails', require: false
  gem 'guard-process', require: false
  gem 'guard-bundler', require: false
end

group :test do
  gem 'mocha'

  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'

  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'webmock', github: 'bblimke/webmock'
  gem 'vcr'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]