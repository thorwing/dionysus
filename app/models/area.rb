class Area < ActiveRecord::Base
  set_primary_key :code
  attr_accessible :name, :code
  has_ancestry

  has_many :locations
  belongs_to :city

  validates_presence_of :name
end
