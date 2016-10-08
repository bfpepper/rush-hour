require_relative '../spec_helper.rb'
require 'pry'

RSpec.describe "Payload" do
  it "is invalid without a url" do

    result = Payload.create(
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referrer_id: 1,
                     request_type_id: 3,
                     event_name_id: 4,
                     agent_id: 15,
                     screen_resolution_id: 7,
                     ip_id: 3545)

    expect(result).to_not be_valid
  end
  it "is invalid without a requested at" do

    result = Payload.create(
                     url_id: 18,
                     responded_in: 37,
                     referrer_id: 1,
                     request_type_id: 3,
                     event_name_id: 4,
                     agent_id: 15,
                     screen_resolution_id: 7,
                     ip_id: 3545)

    expect(result).to_not be_valid
  end
  it "is invalid without a responded in" do

    result = Payload.create(
                     url_id: 18,
                     requested_at: "2013-02-16 21:38:28 -0700",
                     referrer_id: 1,
                     request_type_id: 3,
                     event_name_id: 4,
                     agent_id: 15,
                     screen_resolution_id: 7,
                     ip_id: 3545)

    expect(result).to_not be_valid
  end
  it "is invalid without a referred by" do

    result = Payload.create(
                     url_id: 18,
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     request_type_id: 3,
                     event_name_id: 4,
                     agent_id: 15,
                     screen_resolution_id: 7,
                     ip_id: 3545)

    expect(result).to_not be_valid
  end
  it "is invalid without a request type" do

    result = Payload.create(
                     url_id: 18,
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referrer_id: 1,
                     event_name_id: 4,
                     agent_id: 15,
                     screen_resolution_id: 7,
                     ip_id: 3545)

    expect(result).to_not be_valid
  end
  it "is invalid without a event name" do

    result = Payload.create(
                     url_id: 18,
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referrer_id: 1,
                     request_type_id: 3,
                     agent_id: 15,
                     screen_resolution_id: 7,
                     ip_id: 3545)

    expect(result).to_not be_valid
  end
  it "is invalid without a user agent" do

    result = Payload.create(
                     url_id: 18,
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referrer_id: 1,
                     request_type_id: 3,
                     event_name_id: 4,
                     screen_resolution_id: 7,
                     ip_id: 3545)

    expect(result).to_not be_valid
  end
  it "is invalid without a screen resolution" do

    result = Payload.create(
                     url_id: 18,
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referrer_id: 1,
                     request_type_id: 3,
                     event_name_id: 4,
                     agent_id: 15,
                     ip_id: 3545)

    expect(result).to_not be_valid
  end
  it "is invalid without an ip" do

    result = Payload.create(
                     url_id: 18,
                     requested_at: "2013-02-16 21:38:28 -0700",
                     responded_in: 37,
                     referrer_id: 1,
                     request_type_id: 3,
                     event_name_id: 4,
                     agent_id: 15,
                     screen_resolution_id: 7)

    expect(result).to_not be_valid
  end
  describe ".average_response" do
    it "returns average response time across all payloads" do
      Payload.create(
                       url_id: 18,
                       requested_at: "2013-02-16 21:38:28 -0700",
                       responded_in: 20,
                       referrer_id: 1,
                       request_type_id: 3,
                       event_name_id: 4,
                       agent_id: 15,
                       screen_resolution_id: 7,
                       ip_id: 17)
      Payload.create(
                      url_id: 18,
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 10,
                      referrer_id: 1,
                      request_type_id: 3,
                      event_name_id: 4,
                      agent_id: 15,
                      screen_resolution_id: 7,
                      ip_id: 17)

      expect(Payload.average_response).to eq(15)
    end
  end

  describe ".max_response" do
    it "returns max response time across all payloads" do
      Payload.create(
                       url_id: 18,
                       requested_at: "2013-02-16 21:38:28 -0700",
                       responded_in: 20,
                       referrer_id: 1,
                       request_type_id: 3,
                       event_name_id: 4,
                       agent_id: 15,
                       screen_resolution_id: 7,
                       ip_id: 17)
      Payload.create(
                      url_id: 18,
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 10,
                      referrer_id: 1,
                      request_type_id: 3,
                      event_name_id: 4,
                      agent_id: 15,
                      screen_resolution_id: 7,
                      ip_id: 17)

      expect(Payload.max_response).to eq(20)
    end
  end
end
