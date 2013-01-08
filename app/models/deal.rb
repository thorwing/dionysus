class Deal < ActiveRecord::Base

  #relationships
  belongs_to :beverage
  belongs_to :seller, class_name: "User", foreign_key: 'seller_id'

  #validations
  validates_presence_of :beverage
  validates_presence_of :seller
  validates_presence_of :price
  validates_presence_of :amount
end
