require 'spec_helper'

describe Location do
  it "has a valid factory" do
    FactoryGirl.create(:location).should be_valid
  end
  it "is invalid without name" do
    FactoryGirl.build(:location, name: nil).should_not be_valid
  end
  it "is invalid without encoded name" do
    FactoryGirl.build(:location, encoded_name: nil).should_not be_valid
  end
  it "is invalid without search_id" do
    FactoryGirl.build(:location, search_id: nil).should_not be_valid
  end
  it "creates a Location object for each location entered" do
    locations = CITIES.sample(rand(1..10))
    search = FactoryGirl.create(:search)
    Location.create_all(search, locations)
    Location.where(:search_id => search.id).size.should == locations.size
  end

end

# Controller will need to handle:
# -- display error msg & link to search tips if too many locations entered
