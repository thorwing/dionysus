class Wish < ActiveRecord::Base
  attr_accessible :beverage_id, :accomplished, :remark, :tag_list
  acts_as_taggable
  acts_as_taggable_on :tags

  #relationships
  belongs_to :user
  belongs_to :beverage

  #scopes
  scope :want, where(accomplished: false)
  scope :done, where(accomplished: true)

end
