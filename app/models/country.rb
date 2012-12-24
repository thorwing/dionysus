class Country < ActiveRecord::Base

  #Relationships
  has_many :regions

  #validations
  validates :name,
    presence: true,
    uniqueness: true
end
