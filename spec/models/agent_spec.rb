require_relative '../spec_helper'

  RSpec.describe "Agent" do
    before(:each) do
      @client1 = populate_client_table
      @agent1 = populate_agent_table.first
      @agent2 = populate_agent_table.last
    end

  describe ".browser_breakdown" do
    it "returns the browser breakdown across all payloads" do

      2.times do
        create_payload({agent_id: @agent1.id, client_id: @client1.id})
      end

      create_payload({agent_id: @agent2.id, client_id: @client1.id})

      expect(@client1.agents.browser_breakdown).to eq([@agent1.browser, @agent2.browser])
    end
  end

  describe ".os_breakdown" do
    it "returns the os breakdown across all payloads" do

      2.times do
        create_payload({agent_id: @agent1.id, client_id: @client1.id})
      end

      create_payload({agent_id: @agent2.id, client_id: @client1.id})

      expect(@client1.agents.os_breakdown).to eq([@agent1.os, @agent2.os])
    end
  end
end
