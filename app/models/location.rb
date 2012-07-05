class Location < ActiveRecord::Base

  include EncodeAttr

  belongs_to :search
  attr_accessible :encoded_name, :name, :search
  validates :name, :presence => true
  validates :encoded_name, :presence => true
  validates :search, :presence => true
  after_initialize :encode

  def self.create_all(search, locations)
    ActiveRecord::Base.transaction do
      locations.each do |loc|
        Location.create(:name => loc, :search => search)
      end
    end
  end

end
