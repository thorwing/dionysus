class Wish < ActiveRecord::Base
  attr_accessible :beverage_id, :accomplished, :remark, :rating, :tag_list
  acts_as_taggable
  acts_as_taggable_on :tags

  #relationships
  belongs_to :user
  belongs_to :beverage

  #scopes
  scope :want, where(accomplished: false)
  scope :done, where(accomplished: true)

  validates_numericality_of :rating, greater_than_or_equal_to: 0, less_than_or_equal_to: 5

end
