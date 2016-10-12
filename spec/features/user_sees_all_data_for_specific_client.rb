require_relative '../spec_helper'

RSpec.describe "When a user visits '/sources/:IDENTIFIER/'" do
  it "they see client breakdown information" do
    c1 = Client.create(identifier: "apple", root_url: "wwww.client.com")
    Payload.find_or_create_by({
                                url_id: 1,
                                requested_at: "2013-02-16 21:38:28 -0700",
                                responded_in: 37,
                                referrer_id: 43,
                                request_type_id: 1,
                                event_id: 54,
                                agent_id: 5,
                                ip_id: 53243,
                                screen_resolution_id: 3,
                                client_id: c1.id
                              })

    visit ('/sources/:IDENTIFIER') do
      expect(page).to have_content(37)
    end
  end
end
