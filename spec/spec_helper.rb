# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'database_cleaner'

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
 # config.use_transactional_fixtures = true
  DatabaseCleaner.strategy = :truncation

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
	    santa%20ana%20ca st%20louis riverside%20ca corpus%20christi%20tx Pittsburgh
	    lexington%20ky stockton%20CA Cinncinnati Anchorage St%20Paul%20MN Toledo Newark
	    greensboro%20nc plano%20tx lincoln%20ne Buffalo%20NY Henderson%20NV
	    Fort%20Wayne%20IN Jersey%20City%20NJ chula%20vista%20ca st.%20petersburg%20fl Orlando
	    norfolk%20va Laredo%20TX chandler%20az Madison Lubbock%20TX Durham Winston-Salem
	    garland%20texas glendale%20arizona baton%20rouge%20louisiana hialeah%20florida
	    reno%20nevada chesapeake%20virginia scottsdale%20arizona irving%20texas
	    north%20las%20vegas fremont%20ca irvine%20california san%20bernardino Birmingham
	    gilbert%20az Rochester Boise Spokane montgomery%20alabama des%20moines%20ia)

  JOB_TITLES = ["Account Executive", "Account Manager", "Accountant", "Accounting Intern", "Actuarial Intern", "Administrative Assistant", "Analyst Intern", "Analyst", "Applications Engineer Intern", "Architect Intern", "Architectural Intern", "Art Director", "Assistant Manager", "Assistant Store Manager", "Assistant Vice President", "Associate", "Associate Intern", "Associate Consultant Intern", "Associate Director", "Attorney", "Audit Intern", "Audit Associate", "Audit Associate Intern", "Audit Staff Intern", "Auditor Intern", "Branch Manager", "Business Intern", "Business Analyst Intern", "Business Analyst", "Business Development Manager", "Cashier", "Civil Engineer Intern", "Civil Engineering Intern", "Co-Op Intern", "Co-Op Engineer Intern", "Co-Op Student Intern", "College Intern", "Communications Intern", "Consultant", "Consultant Intern", "Customer Service", "Customer Service Representative", "Data Analyst Intern", "Design Engineer", "Design Engineer Intern", "Developer Intern", "Developer", "Director", "Editorial Intern", "EID Intern", "Electrical Engineer", "Electrical Engineer Intern", "Engineer Intern", "Engineer", "Engineering Intern", "Engineering Co-Op Intern", "Engineering Manager", "Executive Intern", "Executive Assistant", "Finance Intern", "Finance Manager", "Financial Advisor", "Financial Analyst Intern", "Financial Analyst", "Financial Representative Intern", "Flight Attendant", "General Manager", "Graduate Intern", "Graduate Research Intern", "Graduate Research Assistant Intern", "Graduate Technical Intern", "Graphic Designer Intern", "Graphic Designer", "Hardware Engineer Intern", "Human Resources Intern", "Interim Engineering Intern", "Intern", "Investment Banking Analyst Intern", "Investment Banking Summer Analyst Intern", "IT Intern", "IT Analyst Intern", "IT Analyst", "It Manager", "IT Specialist", "Law Clerk Intern", "Management Trainee Intern", "Manager", "Manager Intern", "Marketing Intern", "Marketing Assistant Intern", "Marketing Director", "Marketing Manager", "MBA Intern", "Mechanical Engineer", "Mechanical Engineer Intern", "Mechanical Engineering Intern", "Member of Technical Staff", "Member of Technical Staff Intern", "Network Engineer", "Office Manager", "Operations Analyst Intern", "Operations Manager", "Personal Banker", "Pharmacist", "Pharmacist Intern", "Pharmacy Intern", "Principal Consultant", "Principal Engineer", "Principal Software Engineer", "Process Engineer Intern", "Process Engineer", "Product Manager", "Product Manager Intern", "Product Marketing Manager Intern", "Program Manager", "Program Manager Intern", "Programmer Intern", "Programmer", "Programmer Analyst", "Programmer Analyst Intern", "Project Engineer Intern", "Project Engineer", "Project Manager", "Project Manager Intern", "Public Relations Intern", "QA Intern", "QA Engineer Intern", "R&D Intern", "Recruiter", "Registered Nurse", "Research Intern", "Research Analyst Intern", "Research Assistant Intern", "Research Assistant", "Research Associate", "Research Associate Intern", "Sales", "Sales Intern", "Sales Associate", "Sales Engineer", "Sales Manager", "Sales Representative", "Senior Accountant", "Senior Analyst", "Senior Associate", "Senior Business Analyst", "Senior Consultant", "Senior Director", "Senior Engineer", "Senior Financial Analyst", "cashier", "waitress", "parking valet", "server", "photography", "phlebotomy", "direct care"]


end
