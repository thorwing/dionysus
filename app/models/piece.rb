class Piece < ActiveRecord::Base
  #relationships
  belongs_to :review

  validates_numericality_of :strength, greater_than_or_equal_to: 0, less_than_or_equal_to: 5
end
