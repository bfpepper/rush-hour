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


def setup
  c1 = Client.create(identifier: "apple", root_url: "wwww.client.com")
  Payload.find_or_create_by({
                              url_id: 1,
                              requested_at: "2013-02-16 21:38:28 -0700",
                              responded_in: 37,
                              referrer_id: 43,
                              request_type_id: 1,
                              event_id: 54,
                              agent_id: 5,
                              ip_id: 53243,
                              screen_resolution_id: 3,
                              client_id: c1.id
                            })
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
