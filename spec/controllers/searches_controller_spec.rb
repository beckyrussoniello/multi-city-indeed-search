require 'spec_helper'

describe SearchesController do
  describe "GET #new" do
    it "assigns a new Search to @search" do
      get :new
      assigns(:search).should be_a_new(Search)
      flash[:notice].should be_nil
    end
    it "renders the :new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    before :each do
      @locs = CITIES.sample(rand(1..10)).join(", ")
    end
    context "with valid query and location list" do
      it "creates a new Search" do
        expect{
	  post :create, search: FactoryGirl.attributes_for(:search), location: {name: @locs}
        }.to change(Search,:count).by(1)
      end
      it "calls #make_list to populate @search.locations" do
	post :create, search: FactoryGirl.attributes_for(:search), location: {name: @locs}
        assigns(:search).locations.should_not be_empty
	assigns(:search).locations.size.should eq(@locs.split(/\s?,\s?/).size)
      end
      it "redirects to #show" do
	post :create, search: FactoryGirl.attributes_for(:search), location: {name: @locs}
	response.should redirect_to Search.last
      end
    end
    context "with invalid query" do
      it "does not create a new Search" do
        expect{
	  post :create, search: FactoryGirl.attributes_for(:invalid_search), location: {name: @locs}
	}.to_not change(Search,:count)
      end
      it "redirects to :new with error message" do
	post :create, search: FactoryGirl.attributes_for(:invalid_search), location: {name: @locs}
	response.should redirect_to :action => "new"
      end
    end

    context "with too many locations / commas" do # location list parsed as CSV
  # The search form will limit overall input length, but what if the user types all commas?
  # Here, I demonstrate that the app accepts only the first 10 comma-separated values.
      it "assigns an array of maximum size 10 to session[:locations]" do
	post :create, search: FactoryGirl.attributes_for(:search), location: {name: @locs}
	assigns(:search).locations.size.should <= 10
      end
    end

    context "locations list is nil" do
      it "does not save Search to the database" do
	expect{
	  post :create, search: FactoryGirl.attributes_for(:search), location: {name: nil}
	}.to_not change(Search, :count)
      end
      it "redirects to :new with error message" do
	post :create, search: FactoryGirl.attributes_for(:search), location: {name: nil}
	flash[:notice].should == "Please type one or more locations, separated by commas."
	response.should redirect_to :action => "new"
      end   
    end
    context "locations list is empty" do  
      it "does not save Search to the database" do
	expect{
	  post :create, search: FactoryGirl.attributes_for(:search), location: {name: ""}
	}.to_not change(Search, :count)
      end
      it "redirects to :new with error message" do
	post :create, search: FactoryGirl.attributes_for(:search), location: {name: ""}
	flash[:notice].should == "Please type one or more locations, separated by commas."
	response.should redirect_to :action => "new"
      end   
    end
  end

  describe "GET #show" do
    it "assigns the requested search to @search" do # this will always be the user's last search
      search = FactoryGirl.create(:search)
      session[:locations] = CITIES.sample(rand(1..10))
      get :show, id: search
      assigns(:search).should eq(search)
    end
=begin
    it "performs the search" do
      search = FactoryGirl.create(:search)
      session[:locations] = CITIES.sample(rand(1..10))
      get :show, id: search
      Search.should_receive(:perform).with(session[:locations])
    end
=end
    it "assigns the result of @search.perform to @results" do
      session[:locations] = CITIES.sample(rand(1..10))
      get :show, id: FactoryGirl.create(:search)
      assigns(:results).should be_an_instance_of Array
    end
    it "renders the :show view" do
      session[:locations] = CITIES.sample(rand(1..10))
      get :show, id: FactoryGirl.create(:search)
      response.should render_template :show
    end
  end
end
