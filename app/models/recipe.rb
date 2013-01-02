class Recipe < ActiveRecord::Base
  attr_accessible  :title, :remark, :pic_url, :ingredients_attributes

  #relationships
  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  has_many :ingredients

  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |i| i[:name].blank?}, :allow_destroy => true
end