class Location < ActiveRecord::Base
  attr_accessible :city_id, :area_id, :address

  belongs_to :commentable, polymorphic: true
  belongs_to :city
  belongs_to :area

  geocoded_by :full_city_address   # can also be an IP address
  after_validation :geocode

  def full_city_address
    "#{address}"
  end
end
