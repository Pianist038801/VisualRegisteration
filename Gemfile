source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Ruby Version
ruby '2.3.1'

# Framework
gem 'rails', '~> 5.1.3'
gem 'font-awesome-rails'
gem 'kaminari'
gem 'paperclip'
gem 'nokogiri', '1.8.0'

# Assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby
gem 'coffee-rails', '~> 4.2'
gem "jquery-ui-rails"
# gem 'turbolinks', '~> 5'
gem 'jquery-rails'

# Api
gem 'jbuilder', '~> 2.5'

# Authentications & Security
gem 'devise', '4.3.0'

# Environment Variable
gem 'figaro'

# Other
gem 'simple_form', '~> 3.5.0'

# Database
gem 'mysql2', '0.3.21'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'wdm', '>= 0.1.0' if Gem.win_platform?
end

group :development do
  # Code standard
  gem 'rubocop', require: false

  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
end

# Timezone
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "nested_form"
gem "select2-rails"
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'