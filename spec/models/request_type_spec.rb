require_relative '../spec_helper'

RSpec.describe "RequestType" do
    before(:each) do
      @request1 = populate_request_table.first
      @request2 = populate_request_table.last
    end

  describe ".most_frequent" do
    it "returns the most frequent request type" do

      2.times do
        create_payload({request_type_id: @request1.id})
      end

      create_payload({request_type_id: @request2.id})

      expect(RequestType.most_frequent).to eq("GET")
    end
  end
  
  describe '.all_verbs' do
    it "returns list of all verbs used" do

      2.times do
        create_payload({request_type_id: @request1.id})
      end

      create_payload({request_type_id: @request2.id})

        expect(RequestType.all_verbs).to eq(["GET", "POST"])
    end
  end
end
