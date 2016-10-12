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
