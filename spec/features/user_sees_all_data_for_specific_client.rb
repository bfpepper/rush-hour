require_relative '../spec_helper'

RSpec.describe "When a user visits '/sources/:IDENTIFIER/'" do
  before(:each) do
    setup
  end

  it "they see client breakdown information" do
    visit ('/sources/:IDENTIFIER') do
      expect(page).to have_content(37)
    end
  end

  it "they see appropriate data in average response time" do
    visit ('/sources/:IDENTIFIER') do
      within(".avg") do
        expect("p").to have_content(37)
      end
    end
  end

  it "they see appropriate data in max response time" do
    visit ('/sources/:IDENTIFIER') do
      within(".max") do
        expect("p").to have_content(37)
      end
    end
  end
end
