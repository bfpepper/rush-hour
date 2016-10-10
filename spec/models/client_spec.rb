require_relative '../spec_helper'

RSpec.describe "Client" do
  it "is invalid without identifier" do
    result = Client.create(root_url: "www.whereever.com")

    expect(result).to_not be_valid
  end

  it "is invalid without root_url" do
    result = Client.create(identifier: "something")

    expect(result).to_not be_valid
  end
end
