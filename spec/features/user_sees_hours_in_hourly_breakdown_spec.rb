require_relative '../spec_helper'

RSpec.describe "When a user visits '/sources/jumpstartlab/events/socialLogin'" do
  before(:each) do
    setup
  end

  it "user sees a count of events beside the hour" do
    visit('/sources/jumpstartlab/events/socialLogin')
    within("#4") do
      expect(page).to have_content(1)
    end
  end
end
