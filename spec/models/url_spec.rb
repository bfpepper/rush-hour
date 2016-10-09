require_relative '../spec_helper.rb'

RSpec.describe "Url" do
  it "is valid with a url" do

    result = Url.create(url: "www.google.com")

    expect(result).to be_valid
  end
  it "is invalid without a url" do

    result = Url.create( )

    expect(result).to_not be_valid
  end
  describe '.most_to_least_requested' do
    it "returns list of URLs listed form most requested to least requested" do
      u1 = Url.create(url: "www.google.com")
      u2 = Url.create(url: "www.facebook.com")
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 1,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u2.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

        expect(Url.most_to_least_requested).to eq([u1.url, u2.url])
    end
  end
  describe ".min_response" do
    it "returns the minimun response time form a given URL" do
      u1 = Url.create(url: "www.google.com")
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 1,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
        expect(Url.min_response("www.google.com")).to eq(37)
    end
  end
  describe ".max_response" do
    it "returns the maximum response time form a given URL" do
      u1 = Url.create(url: "www.google.com")
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 1,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
        expect(Url.max_response("www.google.com")).to eq(40)
    end
  end
end
