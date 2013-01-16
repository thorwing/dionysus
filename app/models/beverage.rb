class Beverage < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  include Translatable
  acts_as_taggable_on :grapes
  attr_accessible :type, :name, :trans_name, :alias, :brand_id, :region_id, :rank_id, :volume, :alcohol, :picture, :pic_url, :grape_list

  #relationships
  belongs_to :region
  belongs_to :rank
  belongs_to :brand

  has_many :containers
  has_many :cups, through: :containers
  has_many :vinifications, dependent: :destroy
  has_many :grapes, through: :vinifications
  has_many :reviews
  has_many :wishes
  has_many :checks
  has_many :products
  has_many :deals
  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  has_many :packages, dependent: :destroy
  has_many :lists, through: :packages
  has_many :deals, dependent: :destroy

  #validations
  validates :name,
      presence: true
  validates_presence_of :type

  TYPES = %w[Wine Whisky Vodka Tequila Rum Brandy Liqueur Gin Beer WhiteSpirit ChineseLiqueur RiceWine Sake]

  def self.types
    TYPES.map{|t| [t, I18n.t("beverages.categories.#{t}")]}
  end

  def reviews_score
    reviews.first.try(:score) || 98
  end

  #TODO stub
  def get_picture(version = nil)
    if picture?
      picture_url(version)
    else
      pic_url
    end
  end

end
