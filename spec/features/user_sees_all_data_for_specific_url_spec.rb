require_relative '../spec_helper'

RSpec.describe "When a user visits '/sources/jumpstartlab/urls/blog'" do
  before(:each) do
    setup
  end

  it "user sees data under minimum response time" do
    visit('/sources/jumpstartlab/urls/blog')
    within(".min") do
      expect(page).to have_content(37)
    end
  end

  it "user sees data under maximum response time" do
    visit('/sources/jumpstartlab/urls/blog')
    within(".max") do
      expect(page).to have_content(37)
    end
  end

  it "user sees data under average response time" do
    visit('/sources/jumpstartlab/urls/blog')
    within(".avg") do
      expect(page).to have_content(37)
    end
  end

  it "user sees data under ordered response times" do
    visit('/sources/jumpstartlab/urls/blog')
    within(".order") do
      expect(page).to have_content(37)
    end
  end

  it "user sees data under all HTTP verbs" do
    visit('/sources/jumpstartlab/urls/blog')
    within(".verbs") do
      expect(page).to have_content("GET")
    end
  end

  it "user sees data under 3 most popular referrers" do
    visit('/sources/jumpstartlab/urls/blog')
    within(".referrer") do
      expect(page).to have_content("http://jumpstartlab.com")
    end
  end

  it "user sees data under 3 most popular agents" do
    visit('/sources/jumpstartlab/urls/blog')
    within(".agent") do
      expect(page).to have_content("Macintosh Chrome")
    end
  end
end
