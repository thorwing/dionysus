class Brand < ActiveRecord::Base
  include Translatable
  mount_uploader :picture, PictureUploader
  attr_accessible :name, :trans, :description, :picture, :type_list
  acts_as_taggable_on :types

  #relationships
  has_many :beverages

  #validations
  validates :name,
    presence: true,
    uniqueness: true

end
