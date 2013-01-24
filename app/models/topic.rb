class Topic < ActiveRecord::Base
  attr_accessible :title, :body, :node_id

  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  belongs_to :last_reply_user, class_name: "User", foreign_key: 'last_reply_id'
  belongs_to :node
  has_many :replies, dependent: :destroy

  before_create :init_last_active_mark_on_create
  def init_last_active_mark_on_create
    self.last_active_mark = Time.now.to_i
  end

  #validations
  validates_presence_of :title
  validates_presence_of :body

end
