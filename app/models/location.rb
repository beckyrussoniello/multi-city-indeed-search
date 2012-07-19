class Location < ActiveRecord::Base

  include EncodeAttr

  belongs_to :search
  attr_accessible :encoded_name, :name, :search
  validates :name, :encoded_name, :search, :presence => true
  after_initialize :encode

  def self.create_all(search, locations)
    already_created = search.locations.each_with_object([]) {|loc, ary| ary << loc.name}
    ActiveRecord::Base.transaction do
      locations.each do |loc|
        unless already_created.include?(loc)
	  break if search.locations.size == 10
          Location.create(:name => loc, :search => search)
        end
      end
    end
  end

end
