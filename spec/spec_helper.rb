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
  Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

  payload = '{
              "url":"http://jumpstartlab.com/blog",
              "requestedAt":"2013-02-16 21:38:28 -0700",
              "respondedIn":37,
              "referredBy":"http://jumpstartlab.com",
              "requestType":"GET",
              "eventName": "socialLogin",
              "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
              "resolutionWidth":"1920",
              "resolutionHeight":"1280",
              "ip":"63.29.38.211"
              }'

  input = JSON.parse(payload)

  Payload.create(
                  requested_at: input["requestedAt"],
                  url: Url.find_or_create_by(url: input["url"]),
                  responded_in: input["respondedIn"],
                  referrer: Referrer.find_or_create_by(url: input["referredBy"]),
                  request_type: RequestType.find_or_create_by(request: input["requestType"]),
                  event: Event.find_or_create_by(event: input["eventName"]),
                  agent: Agent.find_or_create_by(os: UserAgent.parse(input["userAgent"].gsub('%3B',';')).platform, browser: UserAgent.parse(input["userAgent"]).browser),
                  screen_resolution: ScreenResolution.find_or_create_by(width: input["resolutionWidth"], height: input["resolutionHeight"]),
                  ip: Ip.find_or_create_by(address: input["ip"]),
                  client: Client.find_by(identifier: "jumpstartlab")
  )
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
