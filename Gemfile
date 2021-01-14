# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.1'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Custom
gem 'gretel', '~> 4.2'
gem 'pagy', '~> 3.10'
gem 'simple_form', '~> 5.0', '>= 5.0.3'
gem 'slim-rails', '~> 3.2'
gem 'sparql-client', '~> 3.1', '>= 3.1.1'

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-awesome_print'
  gem 'pry-rails'
end

group :development, :test do
  gem 'amazing_print'
  gem 'pry-byebug'
end

group :development do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'fasterer'
  gem 'flay'
  gem 'overcommit'
  gem 'rails_best_practices'
  gem 'reek'
  gem 'rubocop', require: false
  gem 'rubycritic', require: false
  gem 'slim_lint'
end
