require 'spec_helper'

describe "job search" do

  it "performs a search with multiple locations" do
    visit root_url
    expect {
      fill_in "search_query", with: "phlebotomy"
      fill_in "location_name", with: "new york chicago" #CITIES.sample(10) #rand(1..10))
      click_button "Search"
    }.to change(Search, :count).by(1)
    page.should have_content "What:"
    page.should have_content "Where:"
    page.should_not have_css ".flash-notice"
    page.should have_css "#results"
    page.should have_css ".result"
    page.should have_css ".job-title"
  end

  it "can do consecutive searches without user hitting back button" do
    visit root_url
    3.times do
      expect {
        fill_in "search_query", with: %w(staff associate cashier sales manager assistant).sample
        fill_in "location_name", with: CITIES.sample(rand(2..10))
        click_button "Search"
      }.to change(Search, :count).by(1)
      page.should_not have_css ".flash-notice"
      page.should have_css "#results"
    end
  end

  it "tells the user if there are no results to display" do
    @query = "dslkfjjklsdjf"
    @locs = "shell wy, greybull wy"
    visit root_url
    expect {
      fill_in "search_query", with: @query
      fill_in "location_name", with: @locs
      click_button "Search"
    }.to change(Search, :count).by(1)
    page.should have_css "#search"
    page.should have_content "Your search did not match any jobs."
  end

  it "displays appropriate error message if location list is empty" do
    visit root_url
    expect {
      fill_in "search_query", with: "jquery"
      fill_in "location_name", with: ""
      click_button "Search"
    }.to_not change(Search, :count)
    page.should have_css "#search"
    page.should have_content "Please type one or more locations, separated by commas."
  end

  it "displays appropriate error message if location list is too long" do
    visit root_url
    expect {
      fill_in "search_query", with: "staff"
      fill_in "location_name", with: CITIES.sample(rand(12..20))
      click_button "Search"
    }.to change(Search, :count).by(1)
      page.should have_css "#results"
    page.should have_content "FYI, we only process"
  end

  it "displays appropriate error message if query is empty" do
    visit root_url
    expect {
      fill_in "search_query", with: ""
      fill_in "location_name", with: CITIES.sample(rand(2..10))
      click_button "Search"
    }.to_not change(Search, :count)
    page.should have_content "Please type a search keyword."
  end

end
