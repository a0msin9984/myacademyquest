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
RSpec.configure do |config|
  # ใช้ transactional fixtures เพื่อเคลียร์ DB หลังแต่ละเทส
  config.use_transactional_fixtures = true

  # Infer spec type จาก folder structure
  config.infer_spec_type_from_file_location!

  # Filter Rails backtrace
  config.filter_rails_from_backtrace!

  # สำหรับ system tests ใช้ Capybara driver
  config.before(:each, type: :system) do
    driven_by(:rack_test)  # หรือ :selenium_chrome_headless ถ้าต้องการ browser จริง
  end
end