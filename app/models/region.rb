class Region < ActiveRecord::Base
  include Translatable
  attr_accessible :parent_id, :name, :trans
  has_ancestry

  scope :of, lambda { |beverage_type| where(beverage_type: beverage_type) }

  #relationships
  has_many :beverages

end
