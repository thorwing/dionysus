class Complain < ActiveRecord::Base
  attr_accessible :remark, :complainable_id, :complainable_type

  belongs_to :author, :class_name => "User", foreign_key: 'author_id'
  belongs_to :complainable, polymorphic: true

  validates_presence_of :author
  validates_presence_of :remark
  validates_length_of :remark, maximum: 400
end
