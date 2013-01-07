class Review < ActiveRecord::Base
  attr_accessible :title, :content, :food_list, :score, :nose_score, :taste_score, :finish_score, :balance_score, :nose_list, :taste_list, :finish_list, :balance_list, :beverage_id, :pieces_attributes
  make_voteable
  acts_as_taggable_on :foods, :noses, :tastes, :finishes, :balances

  #relationships
  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  belongs_to :beverage
  has_many :scores
  has_many :pieces
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :pieces, :reject_if => lambda { |p| p[:flavor].blank?}, :allow_destroy => true

  #validations
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :author

end
