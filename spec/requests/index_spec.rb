require "spec_helper"

describe "The index page", :type => :request do

  it "should display the title" do
    visit "/"
    page.should have_content("Texas")
  end

  it "should show login / registration links" do
    visit "/"
    page.should have_selector("#registration_link")
    page.should have_selector("#login_link")
  end

end
