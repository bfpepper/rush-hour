require_relative '../spec_helper'

RSpec.describe "ScreenResolution" do
  describe ".screen_breakdown" do
    it "returns screen breakdown across all payloads" do
      s1 = populate_screen_resolution_table.first
      s2 = populate_screen_resolution_table.last
      c1 = Client.create(identifier: "apple", root_url: "wwww.client.com")

      2.times do
        create_payload({screen_resolution_id: s1.id, client_id: c1.id})
      end

      create_payload({screen_resolution_id: s2.id, client_id: c1.id})

      # Payload.find_or_create_by({
      #                             url_id: 1,
      #                             requested_at: "2013-02-16 21:38:28 -0700",
      #                             responded_in: 37,
      #                             referrer_id: 43,
      #                             request_type_id: 432,
      #                             event_id: 54,
      #                             agent_id: 24,
      #                             ip_id: 53243,
      #                             screen_resolution_id: s1.id,
      #                             client_id: c1.id
      #                           })
      #
      # Payload.find_or_create_by({
      #                             url_id: 1,
      #                             requested_at: "2013-02-16 21:38:28 -0700",
      #                             responded_in: 37,
      #                             referrer_id: 43,
      #                             request_type_id: 89,
      #                             event_id: 54,
      #                             agent_id: 24,
      #                             ip_id: 53243,
      #                             screen_resolution_id: s1.id,
      #                             client_id: c1.id
      #                           })
      # Payload.find_or_create_by({
      #                             url_id: 1,
      #                             requested_at: "2013-02-16 21:38:28 -0700",
      #                             responded_in: 37,
      #                             referrer_id: 43,
      #                             request_type_id: 3,
      #                             event_id: 54,
      #                             agent_id: 24,
      #                             ip_id: 53243,
      #                             screen_resolution_id: s2.id,
      #                             client_id: c1.id
      #                           })

        expect(c1.screen_resolutions.screen_breakdown).to eq(["#{s1.width} x #{s1.height}", "#{s2.width} x #{s2.height}"])
    end
  end
end
