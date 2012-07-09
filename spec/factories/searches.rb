# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :search do
    query { Faker::Lorem.words.join(" ") }
    encoded_query { self.encode }
  end

  factory :invalid_search, parent: :search do |f|
    f.query nil
  end
end
