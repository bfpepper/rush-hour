require_relative '../spec_helper.rb'
require 'pry'

RSpec.describe "Payload" do
  it "is invalid without a url" do

    result = create_payload_hash({url_id: nil})

    expect(Payload.create(result)).to_not be_valid
  end
  it "is invalid without a requested at" do

    result = create_payload_hash({requested_at: nil})

    expect(Payload.create(result)).to_not be_valid

  end
  it "is invalid without a responded in" do

    result = create_payload_hash({responded_in: nil})

    expect(Payload.create(result)).to_not be_valid

  end
  it "is invalid without a referred by" do

    result = create_payload_hash({referrer_id: nil})

    expect(Payload.create(result)).to_not be_valid

  end
  it "is invalid without a request type" do

    result = create_payload_hash({request_type_id: nil})

    expect(Payload.create(result)).to_not be_valid

  end
  it "is invalid without a event name" do

    result = create_payload_hash({event_id: nil})

    expect(Payload.create(result)).to_not be_valid

  end
  it "is invalid without a user agent" do

    result = create_payload_hash({agent_id: nil})

    expect(Payload.create(result)).to_not be_valid

  end
  it "is invalid without a screen resolution" do

    result = create_payload_hash({screen_resolution_id: nil})

    expect(Payload.create(result)).to_not be_valid

  end
  it "is invalid without an ip" do

    result = create_payload_hash({ip_id: nil})

    expect(Payload.create(result)).to_not be_valid

  end
  it "is invalid without a client id" do

    result = create_payload_hash({client_id: nil})

    expect(Payload.create(result)).to_not be_valid

  end
  describe ".average_response" do
    it "returns average response time across all payloads" do

      create_payload({responded_in: 20})
      create_payload({responded_in: 10})

      expect(Payload.average_response).to eq(15)
    end
  end

  describe ".max_response" do
    it "returns max response time across all payloads" do

      create_payload({responded_in: 20})
      create_payload({responded_in: 10})

      expect(Payload.max_response).to eq(20)
    end
  end

  describe ".min_response" do
    it "returns min response time across all payloads" do

      create_payload({responded_in: 20})
      create_payload({responded_in: 10})

      expect(Payload.min_response).to eq(10)
    end
  end
end
