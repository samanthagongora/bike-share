ENV["RACK_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'
require 'database_cleaner'

Capybara.app = BikeShareApp

RSpec.configure do |c|
  c.include Capybara::DSL
end

DatabaseCleaner.strategy = :truncation
