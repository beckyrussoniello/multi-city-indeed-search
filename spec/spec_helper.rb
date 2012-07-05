# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  CITIES = %w(New%20York Los%20Angeles Chicago Houston Philadelphia Phoenix San%20Antonio 
	    San%20Diego Dallas San%20Jose Jacksonville Indianapolis Austin San%20Francisco
	    Columbus Fort%20Worth Charlotte Detroit El%20Paso Memphis Boston Seattle Denver
	    Baltimore%20MD washington%20dc nashville louisville milwaukee%20wi Portland
	    oklahoma%20city%20ok las%20vegas Albuquerque Tucson Fresno Sacramento Long%20Beach%20CA
	    kansas%20city mesa%20az virginia%20beach Atlanta Colorado%20Springs Raleigh
	    Omaha Miami Tulsa Oakland%20CA Cleveland Minneapolis Wichita arlington%20tx
	    new%20orleans%20la bakersfield%20ca tampa%20fl anaheim%20ca Honolulu aurora%20ca
	    santa%20ana,%20ca st%20louis riverside%20ca corpus%20christi%20tx Pittsburgh
	    lexington,%20ky stockton,%20CA Cinncinnati Anchorage St%20Paul,%20MN Toledo Newark
	    greensboro,%20nc plano,%20tx lincoln,%20ne Buffalo,%20NY Henderson,%20NV
	    Fort%20Wayne,%20IN Jersey%20City,%20NJ chula%20vista%20ca st.%20petersburg%20fl Orlando
	    norfolk,%20va Laredo%20TX chandler%20az Madison Lubbock,%20TX Durham Winston-Salem
	    garland%20texas glendale%20arizona baton%20rouge%20louisiana hialeah%20florida
	    reno%20nevada chesapeake%20virginia scottsdale%20arizona irving%20texas
	    north%20las%20vegas fremont%20ca irvine%20california san%20bernardino Birmingham
	    gilbert%20az Rochester Boise Spokane montgomery%20alabama des%20moines%20ia)

end
