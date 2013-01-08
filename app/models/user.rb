class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  make_voter

  #Relationships
  has_many :wishes
  has_many :reviews, foreign_key: 'author_id'
  has_many :topics, foreign_key: 'author_id'
  has_many :replies, foreign_key: 'author_id'
  has_many :recipes, foreign_key: 'author_id'
  has_many :beverages, foreign_key: 'author_id'
  has_many :lists, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :deals, foreign_key: 'seller_id'

  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

  ROLES = %w[master author merchant]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role_symbols
    roles.map(&:to_sym)
  end

  def role?(role)
    roles.include? role.to_s
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

  def want?(beverage)
    self.wishes.where(beverage_id: beverage.id, accomplished: false).exists?
  end

  def had?(beverage)
    self.wishes.where(beverage_id: beverage.id, accomplished: true).exists?
  end

  def get_wish(beverage)
    self.wishes.where(beverage_id: beverage.id, accomplished: false).first
  end

end
