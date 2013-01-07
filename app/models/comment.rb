class Comment < ActiveRecord::Base
  has_ancestry
  attr_accessible :content, :parent_id, :commentable_id, :commentable_type

  #Relationships
  belongs_to :author, :class_name => "User", foreign_key: 'author_id'
  belongs_to :commentable, polymorphic: true

  #validators
  validates_presence_of :author
  validates_presence_of :content
  validates_length_of :content, maximum: 400

  def commentable
    begin
      commentable_type.singularize.classify.constantize.find(commentable_id)
    rescue
      nil
    end
  end

end
