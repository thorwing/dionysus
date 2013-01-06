class Rank < ActiveRecord::Base
  include Translatable

  #relationships
  has_many :beverages

end
