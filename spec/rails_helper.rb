require 'simplecov'
require 'spec_helper'

puts "Coverage report generated in #{SimpleCov.coverage_dir}"

require "simplecov"
SimpleCov.start "rails" do
  add_filter "/bin/"
  add_filter "/db/"
  add_filter "/config/"
  add_filter "/vendor/"
  add_filter "app/mailers/"
  add_filter "app/jobs/"
end
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
