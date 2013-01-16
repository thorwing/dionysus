class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  make_voter
  acts_as_followable
  acts_as_follower
  acts_as_messageable

  #Relationships
  has_many :activity_feeds
  has_many :wishes
  has_many :reviews, foreign_key: 'author_id'
  has_many :topics, foreign_key: 'author_id'
  has_many :replies, foreign_key: 'author_id'
  has_many :recipes, foreign_key: 'author_id'
  has_many :beverages, foreign_key: 'author_id'
  has_many :lists, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :deals, foreign_key: 'seller_id'
  has_one :location, as: :locationable

  scope :with_role, lambda { |role| where(role: role.to_s) }

  def self.roles
    %w[user master merchant author admin]
  end

  def admin?
    role == "admin"
  end

  def master?
    role == "mater"
  end

  def author?
    role == "author"
  end

  def merchant?
    role == "merchant"
  end

  #TODO stub
  def get_avatar(version = :thumb)
    "/assets/anonymous_m_#{version.to_s}.png"
  end

  def locked_node_ids
    (locked_nodes_list || "").split(",")
  end

  def locked_node_ids=(ids_array)
    if ids_array.is_a? Array
      self.locked_nodes_list = ids_array.join(",")
    end
  end

  def wished?(beverage)
    self.wishes.where(beverage_id: beverage.id).exists?
  end

  def get_wish(beverage)
    self.wishes.where(beverage_id: beverage.id).first
  end

end
