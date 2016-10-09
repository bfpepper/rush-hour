require_relative '../spec_helper'
require 'pry'

RSpec.descibe "RequestType" do
  describe ".most_frequent" do
    r1 = RequestType(request: "GET")
    r2 = RequestType(request: "POST")
    Payload.find_or_create_by({
                                url_id: 1,
                                requested_at: "2013-02-16 21:38:28 -0700",
                                responded_in: 37,
                                referrer_id: 43,
                                request_type_id: r1.id,
                                event_name_id: 54,
                                agent_id: 24,
                                ip_id: 53243,
                                screen_resolution_id: 3
                              })

    Payload.find_or_create_by({
                                url_id: 1,
                                requested_at: "2013-02-16 21:38:28 -0700",
                                responded_in: 37,
                                referrer_id: 43,
                                request_type_id: r1.id,
                                event_name_id: 54,
                                agent_id: 24,
                                ip_id: 53243,
                                screen_resolution_id: 3
                              })
    Payload.find_or_create_by({
                                url_id: 1,
                                requested_at: "2013-02-16 21:38:28 -0700",
                                responded_in: 37,
                                referrer_id: 43,
                                request_type_id: r2.id,
                                event_name_id: 54,
                                agent_id: 24,
                                ip_id: 53243,
                                screen_resolution_id: 3
                              })

  end
end
