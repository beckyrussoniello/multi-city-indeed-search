# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :search do
    query { Faker::Lorem.words.join(" ") }
    encoded_query { self.encode }
  end
end
