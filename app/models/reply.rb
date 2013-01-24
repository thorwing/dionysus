class Reply < ActiveRecord::Base
  attr_accessible :body, :topic_id

  #relationships
  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  belongs_to :topic

end
