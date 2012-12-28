class Review < ActiveRecord::Base
  attr_accessible :title, :content, :score, :beverage_id

  #relationships
  belongs_to :author, :class_name => "User", foreign_key: 'author_id'
  belongs_to :beverage
end
