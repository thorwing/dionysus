class Ingredient < ActiveRecord::Base

  #relationships
  belongs_to :recipe

  #validations
  validates_presence_of :name
  validates_length_of :name, maximum: 20
  validates_length_of :amount, maximum: 10
end
