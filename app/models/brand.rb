class Brand < ActiveRecord::Base
  include Translatable
  attr_accessible :name, :trans, :type_list
  acts_as_taggable_on :types

  #relationships
  has_many :beverages

  #validations
  validates :name,
    presence: true,
    uniqueness: true

end
