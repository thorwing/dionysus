class Reply < ActiveRecord::Base
  #relationships
  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  belongs_to :topic

end
