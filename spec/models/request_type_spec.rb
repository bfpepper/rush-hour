require_relative '../spec_helper'

RSpec.describe "RequestType" do
  describe ".most_frequent" do
    it "returns the most frequent request type" do
    r1 = RequestType.create(request: "GET")
    r2 = RequestType.create(request: "POST")
    Payload.find_or_create_by({
                                url_id: 1,
                                requested_at: "2013-02-16 21:38:28 -0700",
                                responded_in: 37,
                                referrer_id: 43,
                                request_type_id: r1.id,
                                event_id: 54,
                                agent_id: 24,
                                ip_id: 53243,
                                screen_resolution_id: 3,
                                client_id: 3
                              })

    Payload.find_or_create_by({
                                url_id: 1,
                                requested_at: "2013-02-16 21:38:28 -0700",
                                responded_in: 37,
                                referrer_id: 43,
                                request_type_id: r2.id,
                                event_id: 54,
                                agent_id: 24,
                                ip_id: 53243,
                                screen_resolution_id: 3,
                                client_id: 3
                              })
    Payload.find_or_create_by({
                                url_id: 1,
                                requested_at: "2013-02-16 21:38:28 -0700",
                                responded_in: 37,
                                referrer_id: 43,
                                request_type_id: r1.id,
                                event_id: 54,
                                agent_id: 24,
                                ip_id: 53243,
                                screen_resolution_id: 3,
                                client_id: 3
                              })

      expect(RequestType.most_frequent).to eq("GET")
    end
  end
  describe '.all_verbs' do
    it "returns list of all verbs used" do
      r1 = RequestType.create(request: "GET")
      r2 = RequestType.create(request: "POST")
      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: r1.id,
                                  event_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3,
                                  client_id: 3
                                })

      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: r2.id,
                                  event_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3,
                                  client_id: 3
                                })
      Payload.find_or_create_by({
                                  url_id: 1,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  referrer_id: 43,
                                  request_type_id: r1.id,
                                  event_id: 54,
                                  agent_id: 24,
                                  ip_id: 53243,
                                  screen_resolution_id: 3,
                                  client_id: 3
                                })

        expect(RequestType.all_verbs).to eq(["GET", "POST"])
    end
  end
end
