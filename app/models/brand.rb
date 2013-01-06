class Brand < ActiveRecord::Base
  include Translatable
  attr_accessible :name, :trans_name

  #relationships
  has_many :beverages

  #validations
  validates :name,
    presence: true,
    uniqueness: true

end
