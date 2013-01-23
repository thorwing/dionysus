class List < ActiveRecord::Base
  attr_accessible :title, :description

  #relationships
  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  has_many :packages, dependent: :destroy
  has_many :beverages, through: :packages
  has_many :comments, as: :commentable

end
