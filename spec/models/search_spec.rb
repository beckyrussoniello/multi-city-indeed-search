require 'spec_helper'

describe Search do

  it "has a valid factory" do
    FactoryGirl.create(:search).should be_valid
  end

  it "is invalid without a query" do
    FactoryGirl.build(:search, query: nil).should_not be_valid
  end

  it "is invalid without an encoded query" do
    FactoryGirl.build(:search, encoded_query: nil).should_not be_valid
  end

  describe "identify whether too many locations have been supplied" do

    context "<=10 locations" do
      locs = CITIES.sample(rand(1..10))
      Search.too_many?(locs).should == false
    end

    context ">10 locations" do
      locs = CITIES.sample(rand(11..30))
      Search.too_many?(locs).should == true
    end

  end

  describe "Performing the Search" do
    before :each do
      @search = FactoryGirl.create(:search)
      @locs = CITIES.sample(rand(11..20)) # > 10 locs in order to demonstrate that app caps it at 10
    end

    it "processes a maximum of 10 locations at once" do
      @search.perform(@locs)
      @search.locations.size.should_not > 10
    end

    it "calls the Indeed API once for every location" do
      @search.perform(@locs)		  
      @search.api_call_count.should == @locs.size 
    end

    it "gets an array back from the #call_api method" do
      location = FactoryGirl.build(:location, name: CITIES.sample)
      @search.call_api(location).should be_an_instance_of(Array)
    end

    it "returns an array of job postings" do
      results = @search.perform(@locs)
      results.should be_an_instance_of(Array)
      results.each do |res|
        res.should be_an_instance_of(Hash)
        res["jobtitle"].should_not be_nil
      end
    end

  end

  describe "Results" do
    before :each do
      search = Search.create(:query => "associate")
      locs = ["Bloomington, IN", "47401", "Martinsville IN", "Indiana", "47401"]
      @results = search.perform(locs)
    end

    it "(by default) sorts results by most recent" do
      datetimes = []
      @results.each do |res| datetimes << res["date"].to_datetime end
      datetimes.should == datetimes.sort{|x,y| y <=> x}
    end

    it "never returns duplicate job postings" do
      @results.should == @results.uniq
    end
  end

  it "returns empty array if no results to display" do
    search = Search.create(:query => "dkfjslkdjsd") # no results for this
    locs = ["Shell, WY", "Greybull, WY"] # literally 9 people live in Shell
    results = search.perform(locs)
    results.should be_empty
  end

# FUTURE FUNCTIONALITY:
#
# -'minus' in the query / other advanced search features
# -exclude places you DON'T want
# -international
# -limit job posting date
# -sort by relevance
# -separate by city

end
