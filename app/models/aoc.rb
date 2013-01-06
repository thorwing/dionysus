class Aoc < ActiveRecord::Base
  include Translatable

  #relationships
  has_many :beverages
  belongs_to :region
end
