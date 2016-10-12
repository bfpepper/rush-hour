ENV["RACK_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'
require 'database_cleaner'
require 'pry'

DatabaseCleaner.strategy = :truncation

Capybara.app = RushHour::Server

RSpec.configure do |c|
  c.include Capybara::DSL
end

RSpec.configure do |c|
  c.before(:each) do
    DatabaseCleaner.clean
  end
  c.after(:each) do
    DatabaseCleaner.clean
  end
end

def populate_agent_table
  [Agent.create(os: "mac", browser: "chrome"),
  Agent.create(os: "windows", browser: "safari")]
end

def populate_client_table
  Client.create(identifier: "apple", root_url: "wwww.client.com")
end

def populate_request_table
  [RequestType.create(request: "GET"),
  RequestType.create(request: "POST")]
end

def populate_screen_resolution_table
  [ScreenResolution.create(height: "500", width: "5000"),
  ScreenResolution.create(height: "80", width: "800")]
end

def populate_url_table
  [Url.create(url: "www.google.com"),
  Url.create(url: "www.facebook.com")]
end
