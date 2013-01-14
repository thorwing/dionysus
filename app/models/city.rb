class City < ActiveRecord::Base
  set_primary_key :code
  attr_accessible :name, :code

  has_many :locations
  has_many :areas

  validates :name, presence: true, uniqueness: true
end
