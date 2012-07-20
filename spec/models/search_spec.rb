require 'spec_helper'

describe Search do

  context "create valid Search instance" do
    before :each do
      @search = FactoryGirl.create(:search)
    end

    specify { @search.should be_valid }
    
    it "should automatically assign 'encoded query'" do
      Search.create(:query => JOB_TITLES.sample).encoded_query.should_not be_nil
    end
  end

  context "invalid search" do
    before :each do
      @search_without_query = FactoryGirl.build(:search, query: nil)
      @search_without_encoded_query = FactoryGirl.build(:search, encoded_query: nil)
    end

    specify {@search_without_query.should_not be_valid}
    specify {@search_without_encoded_query.should_not be_valid}

  end

  describe "::too_many? takes String of comma-separated locations, returns true if more than 10" do
    before :each do
      @ok_nbr_of_locs = CITIES.sample(rand(1..10)).join(", ")
      @too_many_locs = locs = CITIES.sample(11).join(", ")
    end

    specify {Search.too_many?(@ok_nbr_of_locs).should eql(false)}

    specify {Search.too_many?(@too_many_locs).should eql(true)}
  end

  describe "Performing the Search" do
    before :each do
      @search = FactoryGirl.create(:search)
      @search.make_list CITIES.sample(rand(2..10)).join(", ")
    end

    it "processes a maximum of 10 locations at once" do
      @search.make_list CITIES.sample(rand(11..15)).join(", ")
      @search.perform
      @search.locations.size.should_not > 10
    end

    it "calls the Indeed API once for every location" do
      @search.perform		  
      @search.api_call_count.should == @search.locations.size 
    end

    it "gets an array back from the #call_api method" do
      location = FactoryGirl.build(:location, name: CITIES.sample)
      @search.call_api(location).should be_an_instance_of(Array)
    end

    it "returns an array of job postings" do
      results = @search.perform
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
      search.make_list("Bloomington IN, 47401, Martinsville IN, Indiana, 47401")
      @results = search.perform
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
    search.make_list "Shell, WY, Greybull, WY" # literally 9 people live in Shell
    results = search.perform
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
