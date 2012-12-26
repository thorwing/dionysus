class Grape < ActiveRecord::Base
  has_many :vinifications
  has_many :beverages, through: :vinifications
end
