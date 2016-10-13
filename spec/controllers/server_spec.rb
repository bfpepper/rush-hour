require_relative '../spec_helper'

RSpec.describe "Server" do
  it "returns Missing Parameters message" do
    post '/sources', {}
    expect(last_response.body).to include("Missing Parameters")
  end

  it "returns Missing Payload message" do
    post '/sources/apple/data', {}
    expect(last_response.body).to include("Missing Payload")
  end

  it "returns No Client message" do
    post '/sources/reddit/data', {payload: {"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}}, {identifier: 'reddit'}

    expect(last_response.body).to include("No Client")
  end
end
