%w(cgi json net/http).each { |x| require x }

class Search < ActiveRecord::Base

  include EncodeAttr

  attr_accessible :encoded_query, :query
  attr_accessor :api_call_count
  validates :query, :encoded_query, :presence => :true
  after_initialize :encode
  has_many :locations
  validates_associated :locations

  def perform
   # Location.create_all(self, locs[0..LOCS_LIMIT])
    results = []
    self.locations.each do |loc|
      results_in_loc = self.call_api(loc)
      results_in_loc.each do |item| 
        results << self.simplify(item)
      end
    end
    results.ensure_uniq.sort_by_date
  end

  def locations
    Location.where(:search_id => self.id)
  end

  def self.too_many?(locations)
    return locations.scan(/,/).size > LOCS_LIMIT
  end

  def make_list(location_string)
    locs = location_string.split(/\s?,\s?/).uniq[0..LOCS_LIMIT]
    Location.create_all(self, locs)
  end

  def simplify(hash)
    hash.keep_if {|key| RELEVANT_KEYS.index(key)} # , value
  end

  def call_api(loc)
    uri = URI.parse("#{BASE_URI}?publisher=#{API_KEY}&q=#{self.encoded_query}&l=#{loc.encoded_name}#{END_OF_URI}")
    page = Net::HTTP.get(uri)
    @api_call_count ||= 0
    @api_call_count += 1 unless page.nil? or page.empty?
    json = JSON.parse(page)
    json["results"]
  end
end
