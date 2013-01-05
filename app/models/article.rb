class Article < ActiveRecord::Base
  attr_accessible :title, :body

  scope :unreleased, where(released_at: nil)

  belongs_to :author, class_name: "User", foreign_key: 'author_id'


end
