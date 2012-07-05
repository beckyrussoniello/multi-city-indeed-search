# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'


FactoryGirl.define do
  factory :location do
    name {[CITIES.sample, Faker::Address.state, Faker::Address.zip_code].sample}
    encoded_name "MyString"
    search { FactoryGirl.create(:search) }
  end

end
