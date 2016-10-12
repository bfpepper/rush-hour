require_relative '../spec_helper'

RSpec.describe "When a user visits '/sources/jumpstartlab/'" do
  before(:each) do
    setup
  end

  it "they see appropriate data in average response time" do
    visit ('/sources/jumpstartlab')
    within(".avg") do
      expect(page).to have_content(37)
    end
  end

  it "they see appropriate data in max response time" do
    visit ('/sources/jumpstartlab')
    within(".max") do
      expect(page).to have_content(37)
    end
  end

  it "they see appropriate data in min response time" do
    visit ('/sources/jumpstartlab')
    within(".min") do
      expect(page).to have_content(37)
    end
  end

  it "they see appropriate data in most frequent response type" do
    visit ('/sources/jumpstartlab')
    within(".type_freq") do
      expect(page).to have_content("GET")
    end
  end

  it "they see appropriate data in list of HTTP Verbs" do
    visit ('/sources/jumpstartlab')
    within(".type_freq") do
      expect(page).to have_content("GET")
    end
  end

  it "they see appropriate data in list of URLs" do
    visit ('/sources/jumpstartlab')
    within(".url_freq") do
      expect(page).to have_content(" http://jumpstartlab.com/blog")
    end
  end

  it "they see appropriate data in the browser breakdown" do
    visit ('/sources/jumpstartlab')
    within(".browser") do
      expect(page).to have_content("Chrome")
    end
  end

  it "they see appropriate data in the os breakdown" do
    visit ('/sources/jumpstartlab')
    within(".os") do
      expect(page).to have_content("Macintosh")
    end
  end

  it "they see appropriate data in the os breakdown" do
    visit ('/sources/jumpstartlab')
    within(".screen") do
      expect(page).to have_content("1920 x 1280")
    end
  end

  it "they can click onto url specific link and it will got them" do
    visit ('/sources/jumpstartlab')
    click_link("http://jumpstartlab.com/blog")
    expect(page).to have_content("Specific URL")
  end

end
