require_relative '../spec_helper.rb'
require 'pry'

RSpec.describe "Payload" do
  it "is invalid without a url" do

    result = Payload.create(
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referred_by: "http://jumpstartlab.com",
                     request_type: "GET",
                     event_name: "socialLogin",
                     user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                     resolution_width: "1920",
                     resolution_height: "1280",
                     ip: "63.29.38.211")

    expect(result).to_not be_valid
  end
  it "is invalid without a requested at" do

    result = Payload.create(
                     url: "http://jumpstartlab.com",
                     responded_in: 37,
                     referred_by: "http://jumpstartlab.com",
                     request_type: "GET",
                     event_name: "socialLogin",
                     user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                     resolution_width: "1920",
                     resolution_height: "1280",
                     ip: "63.29.38.211")

    expect(result).to_not be_valid
  end
  it "is invalid without a responded in" do

    result = Payload.create(
                     url: "http://jumpstartlab.com",
                     requested_at: "2013-02-16 21:38:28 -0700",
                     referred_by: "http://jumpstartlab.com",
                     request_type: "GET",
                     event_name: "socialLogin",
                     user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                     resolution_width: "1920",
                     resolution_height: "1280",
                     ip: "63.29.38.211")

    expect(result).to_not be_valid
  end
  it "is invalid without a referred by" do

    result = Payload.create(
                     url: "http://jumpstartlab.com",
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     request_type: "GET",
                     event_name: "socialLogin",
                     user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                     resolution_width: "1920",
                     resolution_height: "1280",
                     ip: "63.29.38.211")

    expect(result).to_not be_valid
  end
  it "is invalid without a request type" do

    result = Payload.create(
                     url: "http://jumpstartlab.com",
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referred_by: "http://jumpstartlab.com",
                     event_name: "socialLogin",
                     user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                     resolution_width: "1920",
                     resolution_height: "1280",
                     ip: "63.29.38.211")

    expect(result).to_not be_valid
  end
  it "is invalid without a event name" do

    result = Payload.create(
                     url: "http://jumpstartlab.com",
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referred_by: "http://jumpstartlab.com",
                     request_type: "GET",
                     user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                     resolution_width: "1920",
                     resolution_height: "1280",
                     ip: "63.29.38.211")

    expect(result).to_not be_valid
  end
  it "is invalid without a user agent" do

    result = Payload.create(
                     url: "http://jumpstartlab.com",
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referred_by: "http://jumpstartlab.com",
                     request_type: "GET",
                     event_name: "socialLogin",
                     resolution_width: "1920",
                     resolution_height: "1280",
                     ip: "63.29.38.211")

    expect(result).to_not be_valid
  end
  it "is invalid without a resolution width" do

    result = Payload.create(
                     url: "http://jumpstartlab.com",
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referred_by: "http://jumpstartlab.com",
                     request_type: "GET",
                     event_name: "socialLogin",
                     user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                     resolution_height: "1280",
                     ip: "63.29.38.211")

    expect(result).to_not be_valid
  end
  it "is invalid without a resolution height" do

    result = Payload.create(
                     url: "http://jumpstartlab.com",
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referred_by: "http://jumpstartlab.com",
                     request_type: "GET",
                     event_name: "socialLogin",
                     user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                     resolution_width: "1920",
                     ip: "63.29.38.211")

    expect(result).to_not be_valid
  end
  it "is invalid without an ip" do

    result = Payload.create(
                     url: "http://jumpstartlab.com",
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referred_by: "http://jumpstartlab.com",
                     request_type: "GET",
                     event_name: "socialLogin",
                     user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                     resolution_width: "1920",
                     resolution_height: "1280")

    expect(result).to_not be_valid
  end
end
