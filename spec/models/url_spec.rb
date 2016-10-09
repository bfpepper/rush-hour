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
        expect(Url.max_response(u1.url)).to eq(40)
    end
  end
  describe ".ordered_response_times" do
    it "returns an order list of response times from slowest to fastest." do
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
                                  responded_in: 50,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      expect(Url.ordered_response_times(u1.url)).to eq([50, 37])
    end
  end
  describe ".averaged_response_time" do
    it "returns the average response time." do
      u1 = Url.create(url: "www.google.com")
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 40,
                                  request_type_id: 1,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 50,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      expect(Url.average_response_time(u1.url)).to eq(45)
    end
  end
  describe ".request_type" do
    it "returns a list of all http verbs." do
      u1 = Url.create(url: "www.google.com")
      r1 = RequestType.create(request: "GET")
      r2 = RequestType.create(request: "PUT")
      RequestType.create(request: "POST")
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 40,
                                  request_type_id: r1.id,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 50,
                                  referrer_id: 43,
                                  request_type_id: r2.id,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 50,
                                  referrer_id: 43,
                                  request_type_id: r1.id,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      expect(Url.verb_list(u1.url)).to eq(["GET", "PUT"])
    end
  end
  describe ".top_referrers" do
    it "returns a list of top 3 referrers" do
      u1 = Url.create(url: "www.google.com")
      r1 = Referrer.create(url: "www.google.com")
      r2 = Referrer.create(url: "www.facebook.com")
      r3 = Referrer.create(url: "www.today.turing.io")
      r4 = Referrer.create(url: "www.cnn.com")
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: r1.id,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: r1.id,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: r1.id,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                url_id: u1.id,
                                requested_at: "2013-02-16 21:38:28 -0700",
                                responded_in: 40,
                                referrer_id: r4.id,
                                request_type_id: 3,
                                event_name_id: 54,
                                agent_id: 24,
                                ip_id: 53243,
                                screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: r1.id,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: r2.id,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: r2.id,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: r2.id,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: r3.id,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: r3.id,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

      expect(Url.top_referrers(u1.url)).to eq([r1.url, r2.url, r3.url])
    end
  end

  describe ".top_agents" do
    it "returns a list of top 3 agents" do
      u1 = Url.create(url: "www.google.com")
      a1 = Agent.create(os: "mac", browser: "chrome")
      a2 = Agent.create(os: "mac", browser: "safari")
      a3 = Agent.create(os: "windows", browser: "chrome")
      a4 = Agent.create(os: "windows", browser: "ie3")
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 54,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: a4.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 64,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: a1.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 74,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: a1.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                url_id: u1.id,
                                requested_at: "2013-02-16 21:38:28 -0700",
                                responded_in: 40,
                                referrer_id: 75,
                                request_type_id: 3,
                                event_name_id: 54,
                                agent_id: a1.id,
                                ip_id: 53243,
                                screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 6,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: a1.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 65,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: a2.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 76,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: a2.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 76,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: a2.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 99,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: a3.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: u1.id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 40,
                                  referrer_id: 23,
                                  request_type_id: 3,
                                  event_name_id: 54,
                                  agent_id: a3.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

      expect(Url.top_agents(u1.url)).to eq(["#{a1.os} #{a1.browser}", "#{a2.os} #{a2.browser}","#{a3.os} #{a3.browser}"])
    end
  end
end
