class Check < ActiveRecord::Base
  attr_accessible :beverage_id, :remark, :star, :tag_list
  acts_as_taggable
  acts_as_taggable_on :tags

  #relationships
  belongs_to :author, :class_name => "User", foreign_key: 'author_id'
  belongs_to :beverage
end
