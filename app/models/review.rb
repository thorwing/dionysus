class Review < ActiveRecord::Base
  attr_accessible :title, :content, :score, :beverage_id, :pieces_attributes, :food_list
  make_voteable
  acts_as_taggable
  acts_as_taggable_on :foods

  #relationships
  belongs_to :author, :class_name => "User", foreign_key: 'author_id'
  belongs_to :beverage
  has_many :scores
  has_many :pieces

  accepts_nested_attributes_for :pieces, :reject_if => lambda { |p| p[:flavor].blank?}, :allow_destroy => true

end
