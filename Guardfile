# frozen_string_literal: true

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exist?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"
interactor :simple

guard "livereload" do
  extensions = {
    css: :css,
    scss: :css,
    sass: :css,
    html: :html,
    png: :png,
    gif: :gif,
    jpg: :jpg,
    jpeg: :jpeg,
  }

  rails_view_exts = %w(erb haml slim)

  # file types LiveReload may optimize refresh for
  compiled_exts = extensions.values.uniq
  watch %r{public/.+\.(#{compiled_exts * '|'})}

  extensions.each do |ext, type|
    watch(%r{
          (?:app|vendor)
          (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
           (?<ext>\.#{ext})) # matching extension (must be first encountered)
          (?:\.\w+|$) # other extensions
          }x) do |m|
      path = m[1]
      "/assets/#{path}.#{type}"
    end
  end

  # file needing a full reload of the page anyway
  watch %r{app/views/.+\.(#{rails_view_exts * '|'})$}
  watch %r{app/helpers/.+\.rb}
  watch %r{config/locales/.+\.yml}
end

guard :rails, port: 3000, host: "0.0.0.0" do
  # watch 'Gemfile.lock'
  watch %r{^(config|lib)/.*}
end

guard :process, name: "webpacker", command: [
  "bundle", "exec", "bin/webpack-dev-server"
] do
  watch "yarn.lock"
  watch "package.json"
  watch "babel.config.js"
end

guard :bundler do
  require "guard/bundler"
  require "guard/bundler/verify"
  helper = Guard::Bundler::Verify.new

  files = ["Gemfile"]
  files += Dir["*.gemspec"] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard :minitest, cli: "-b" do
  # Run everything within 'test' if the test helper changes
  watch(%r{^test/test_helper\.rb$}) { "test" }

  # Run everything within 'test/system' if ApplicationSystemTestCase changes
  watch(%r{^test/application_system_test_case\.rb$}) { "test/system" }

  # Run the corresponding test anytime something within 'app' changes
  #   e.g. 'app/models/example.rb' => 'test/models/example_test.rb'
  watch(%r{^app/(.+)\.(rb|html.erb)$}) { |m| "test/#{m[1]}_test.rb" }

  watch(%r{^test/snapshots/(.+)\.snap\.txt$}) do |m|
    test_file = "test/components/#{m[1].gsub(%r{/[^/]+\w+$}, '.rb')}"
    test_file
  end

  # Run a test any time it changes
  watch(%r{^test/.+_test\.rb$})

  # Run everything in or below 'test/controllers' everytime
  #   ApplicationController changes
  # watch(%r{^app/controllers/application_controller\.rb$}) do
  #   'test/controllers'
  # end

  # Run integration test every time a corresponding controller changes
  # watch(%r{^app/controllers/(.+)_controller\.rb$}) do |m|
  #   "test/integration/#{m[1]}_test.rb"
  # end

  # Run mailer tests when mailer views change
  # watch(%r{^app/views/(.+)_mailer/.+}) do |m|
  #   "test/mailers/#{m[1]}_mailer_test.rb"
  # end
end
