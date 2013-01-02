class Article < ActiveRecord::Base
  attr_accessible :title, :body

  belongs_to :author, class_name: "User", foreign_key: 'author_id'

end