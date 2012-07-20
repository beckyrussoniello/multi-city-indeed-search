# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
#require 'spec_helper'

FactoryGirl.define do
  factory :search do
    query { JOB_TITLES.sample }
    encoded_query {self.encode}
  end

  factory :invalid_search, parent: :search do |f|
    f.query nil
  end
end
