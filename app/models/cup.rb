class Cup < ActiveRecord::Base

  has_many :containers
  has_many :beverages, through: :containers
end
