class Ingredient < ActiveRecord::Base

  #relationships
  belongs_to :recipe

  #validations
  validates_presence_of :name
  validates_length_of :name, maximum: 200
  validates_length_of :amount, maximum: 100
end
