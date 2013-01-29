class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :crop_x, :crop_y, :crop_h, :crop_w
  attr_accessible :avatar, :avatar_cache, :remove_avatar, :email, :nick, :password, :remember_me, :password_confirmation, :crop_x, :crop_y, :crop_h, :crop_w

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
  has_many :articles, foreign_key: 'author_id'
  has_many :lists, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :deals, foreign_key: 'seller_id'
  has_one :location, as: :locationable

  # bypasses Devise's requirement to re-enter current password to edit
  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

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

  def self.text_search(query)
    where("nick like ?", "%#{query}%")
  end

  #TODO stub
  def get_avatar(version = nil)
    if avatar?
      avatar_url(version)
    else
      "/assets/anonymous_m_#{version.to_s}.png"
    end
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
