require_relative '../spec_helper'

  RSpec.describe "Agent" do
    before(:each) do
      @client1 = populate_client_table
      @agent1 = populate_agent_table.first
      @agent2 = populate_agent_table.last
    end

  describe ".browser_breakdown" do
    it "returns the browser breakdown across all payloads" do

      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 1,
                                  event_id: 54,
                                  agent_id: @agent1.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3,
                                  client_id: @client1.id
                                })

      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_id: 54,
                                  agent_id: @agent1.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3,
                                  client_id: @client1.id
                                })
      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_id: 54,
                                  agent_id: @agent2.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3,
                                  client_id: @client1.id
                                })

        expect(@client1.agents.browser_breakdown).to eq([@agent1.browser, @agent2.browser])
    end
  end

  describe ".os_breakdown" do
    it "returns the os breakdown across all payloads" do

      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 1,
                                  event_id: 54,
                                  agent_id: @agent1.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3,
                                  client_id: @client1.id
                                })

      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_id: 54,
                                  agent_id: @agent1.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3,
                                  client_id: @client1.id
                                })
      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_id: 54,
                                  agent_id: @agent2.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3,
                                  client_id: @client1.id
                                })

        expect(@client1.agents.os_breakdown).to eq([@agent1.os, @agent2.os])
    end
  end
end
