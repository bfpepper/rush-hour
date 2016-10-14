require_relative '../spec_helper.rb'

RSpec.describe "Url" do
  before(:each) do
    @url1 = populate_url_table.first
    @url2 = populate_url_table.last
    @client1 = populate_client_table
    @request1 = populate_request_table.first
    @request2 = populate_request_table.last
  end
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

      2.times do
        create_payload({url_id: @url1.id, client_id: @client1.id})
      end

      create_payload({url_id: @url2.id, client_id: @client1.id})

      expect(@client1.urls.most_to_least_requested).to eq([@url1.url, @url2.url])
    end
  end

  describe ".min_response" do
    it "returns the minimun response time form a given URL" do

      create_payload({url_id: @url1.id, responded_in: 37})
      create_payload({url_id: @url1.id, responded_in: 40})

      expect(@url1.min_response).to eq(37)
    end
  end

  describe ".max_response" do
    it "returns the maximum response time form a given URL" do

      create_payload({url_id: @url1.id, responded_in: 37})
      create_payload({url_id: @url1.id, responded_in: 40})

        expect(@url1.max_response).to eq(40)
    end
  end

  describe ".ordered_response_times" do
    it "returns an order list of response times from slowest to fastest." do

      create_payload({url_id: @url1.id, responded_in: 37})
      create_payload({url_id: @url1.id, responded_in: 50})

      expect(@url1.ordered_response_times).to eq([50, 37])
    end
  end

  describe ".averaged_response_time" do
    it "returns the average response time." do

      create_payload({url_id: @url1.id, responded_in: 40})
      create_payload({url_id: @url1.id, responded_in: 50})

      expect(@url1.average_response_time).to eq(45)
    end
  end

  describe ".request_type" do
    it "returns a list of all http verbs." do
      @request1 = RequestType.create(request: "GET")
      @request2 = RequestType.create(request: "PUT")
      RequestType.create(request: "POST")

      2.times do
        create_payload({url_id: @url1.id, request_type_id: @request1.id})
      end

      create_payload({url_id: @url1.id, request_type_id: @request2.id})

      expect(@url1.verb_list).to eq(["GET", "PUT"])
    end
  end

  describe ".top_referrers" do
    it "returns a list of top 3 referrers" do
      r1 = Referrer.create(url: "www.google.com")
      r2 = Referrer.create(url: "www.facebook.com")
      r3 = Referrer.create(url: "www.today.turing.io")
      r4 = Referrer.create(url: "www.cnn.com")

      4.times do
        create_payload({url_id: @url1.id, referrer_id: r1.id})
      end

      3.times do
        create_payload({url_id: @url1.id, referrer_id: r2.id})
      end

      2.times do
        create_payload({url_id: @url1.id, referrer_id: r3.id})
      end

      create_payload({url_id: @url1.id, referrer_id: r4.id})

      expect(@url1.top_referrers).to eq([r1.url, r2.url, r3.url])
    end
  end

  describe ".top_agents" do
    it "returns a list of top 3 agents" do
      a1 = Agent.create(os: "mac", browser: "chrome")
      a2 = Agent.create(os: "mac", browser: "safari")
      a3 = Agent.create(os: "windows", browser: "chrome")
      a4 = Agent.create(os: "windows", browser: "ie3")

      4.times do
        create_payload({url_id: @url1.id, agent_id: a1.id})
      end

      3.times do
          create_payload({url_id: @url1.id, agent_id: a2.id})
      end

      2.times do
          create_payload({url_id: @url1.id, agent_id: a3.id})
      end

      create_payload({url_id: @url1.id, agent_id: a4.id})

      expect(@url1.top_agents).to eq(["#{a1.os} #{a1.browser}", "#{a2.os} #{a2.browser}","#{a3.os} #{a3.browser}"])
    end
  end
end
