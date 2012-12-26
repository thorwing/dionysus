class Brand < ActiveRecord::Base

  #relationships
  has_many :beverages
end
