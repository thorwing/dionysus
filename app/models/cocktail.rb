class Cocktail < ActiveRecord::Base
  include Translatable
  attr_accessible :name

  has_many :recipes
end
