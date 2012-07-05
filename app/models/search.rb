require 'cgi'
require 'json'
require 'net/http'

class Search < ActiveRecord::Base

  include EncodeAttr

  attr_accessible :encoded_query, :query
  attr_accessor :api_call_count
  validates :query, :presence => :true
  validates :encoded_query, :presence => :true
  after_initialize :encode

  BASE_URI = 'http://api.indeed.com/ads/apisearch'
  API_KEY = '3990618342905680'
  RELEVANT_KEYS = ["jobtitle", "company", "formattedLocation", "date", "source", "snippet", "url", "formattedRelativeTime"]
  LOCS_LIMIT = 9 # 10 locations is the max, so 9 is the max array index

  def perform(locs)
    Location.create_all(self, locs[0..LOCS_LIMIT])
    results = []
    self.locations.each do |loc|
      results_in_loc = self.call_api(loc)
      results_in_loc.each do |item| 
        results << self.simplify(item)
      end
    end
    results.uniq.sort_by_date
  end

  def locations
    Location.where(:search_id => self.id)
  end

  def self.too_many?(locations)
    return locations.size > 10
  end

  def simplify(hash)
    hash.keep_if {|key, value| RELEVANT_KEYS.index(key)}
  end

# protected -- commented out for testing...should I really do this?

  def call_api(loc)
    uri = URI.parse("#{BASE_URI}?publisher=#{API_KEY}&q=#{self.encoded_query}&l=#{loc.encoded_name}&sort=&radius=0&v=2&format=json")
    page = Net::HTTP.get(uri)
    @api_call_count ||= 0
    @api_call_count += 1 unless page.nil? or page.empty?
    json = JSON.parse(page)
    json["results"]
  end
end
