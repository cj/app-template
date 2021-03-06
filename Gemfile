# frozen_string_literal: true
source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "2.7.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.1.1"

# Use pg as the database for Active Record
gem "pg", "~> 1.1"

# Use Puma as the app server
gem "puma", "~> 5.0"

# Use SCSS for stylesheets
gem "sass-rails", ">= 6"

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 5.0"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Active Model has_secure_password
gem "bcrypt", "~> 3.1.7"

# Rails engine for cache-friendly, client-side local time
gem "local_time", "~> 2.0"

# Use Active Storage variant
gem "image_processing", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "break"
  gem "spring"

  # Code critics
  gem "solargraph"
  gem "reek", ">= 6.0.2", require: false
  gem "rubocop", ">= 0.72", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-shopify", require: false
  gem "super_awesome_print_rubocop"
  # waiting for https://github.com/castwide/solargraph-reek/pull/1 to get merged in
  gem "solargraph-reek", github: "parruda/solargraph-reek", branch: "patch-1"
  # waiting for https://github.com/Shopify/erb-lint/issues/197 to get merged in
  gem "erb_lint", require: false, github: "cj/erb-lint"
  gem "ruumba", require: false
  gem "scss_lint", "~> 0.50", require: false
  gem "bundler-audit",
    "~> 0.4",
      github: "basecamp/bundler-audit",
      branch: "thor-bump",
      require: false
  gem "brakeman", ">= 4.0", require: false
  gem "benchmark-ips", require: false
  gem "bullet"

  gem "dotenv-rails", "~> 2.7", require: "dotenv/rails-now"

  gem "awesome_print", "~> 2.0.0.pre2"
  gem "super_awesome_print"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 4.1.0"

  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  # gem "rack-mini-profiler", "~> 2.0"
  gem "listen", "~> 3.3"
  gem "faker", require: false

  # Handle live reloading
  gem "guard", github: "guard/guard"
  gem "guard-minitest", "~> 2.4"
  gem "guard-livereload", "~> 2.5", require: false
  gem "rack-livereload"
  gem "guard-rails", github: "atd/guard-rails", require: false
  gem "guard-process", require: false
  gem "guard-bundler", require: false

  gem "better_errors"
  gem "binding_of_caller"

  gem "letter_opener"

  gem "annotate", "~> 3.1"

  gem "lol_dba", "~> 2.2"
end

group :test do
  gem "mocha"

  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"

  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
  gem "webmock", github: "bblimke/webmock"
  gem "vcr"

  # gem "minitest-spec-rails", "~> 6.0.3"
  gem "minitest-reporters", "~> 1.4"
  gem "minitest-snapshots", "~> 0.3.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
# Generate short unique id's
gem "nanoid"
# Handle authentication
gem "jwt", require: false # for JWT feature
gem "rotp", require: false # for OTP feature
gem "rqrcode", require: false # for OTP feature
gem "webauthn", require: false # for WebAuthn feature
gem "view_component", require: "view_component/engine", github: "cj/view_component", branch: "main"

gem "i18n-js", "~> 3.8"

gem "blind_index", "~> 2.2"
gem "lockbox", "~> 0.6.1"

gem "devise", "~> 4.7"
gem "devise-i18n", "~> 1.9"
gem "devise_invitable", "~> 2.0"
gem "devise_masquerade", github: "excid3/devise_masquerade"
gem "omniauth", "~> 1.9.1"

# gem "strong_migrations"

gem "anycable-rails", "~> 1.0"

gem "rails-i18n", "~> 6.0"

gem "turbo-rails", "~> 0.5.3"

gem "cuid", "~> 1.0"

gem "request_store", "~> 1.5"

gem "oj", "~> 3.10"

gem "invisible_captcha", "~> 1.1"

gem "name_of_person", "~> 1.1"

gem "logstop", "~> 0.2.6"

gem "inline_svg", "~> 1.7"

gem "rolify", "~> 5.3"

gem "deep_merge", "~> 1.2", require: "deep_merge/rails_compat"
