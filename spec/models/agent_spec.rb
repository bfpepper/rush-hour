require_relative '../spec_helper'

RSpec.describe "Agent" do
  describe ".browser_breakdown" do
    it "returns the browser breakdown across all payloads" do
      a1 = Agent.create(os: "mac", browser: "chrome")
      a2 = Agent.create(os: "windows", browser: "safari")

      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 1,
                                  event_id: 54,
                                  agent_id: a1.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_id: 54,
                                  agent_id: a1.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_id: 54,
                                  agent_id: a2.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

        expect(Agent.browser_breakdown).to eq([a1.browser, a2.browser])
    end
  end

  describe ".os_breakdown" do
    it "returns the os breakdown across all payloads" do
      a1 = Agent.create(os: "mac", browser: "chrome")
      a2 = Agent.create(os: "windows", browser: "safari")

      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 1,
                                  event_id: 54,
                                  agent_id: a1.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_id: 54,
                                  agent_id: a1.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: 2,
                                  event_id: 54,
                                  agent_id: a2.id,
                                  ip_id: 53243,
                                  screen_resolution_id: 3
                                })

        expect(Agent.os_breakdown).to eq([a1.os, a2.os])
    end
  end
end
