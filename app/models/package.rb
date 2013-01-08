class Package < ActiveRecord::Base
  attr_accessible :list_id, :beverage_id, :remark

  belongs_to :list
  belongs_to :beverage

  #validations
  validates_presence_of :list
  validates_presence_of :beverage
end
