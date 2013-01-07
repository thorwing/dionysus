class Beverage < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  include Translatable
  attr_accessible :type, :name, :trans_name, :region_id, :volume, :alcohol, :picture, :pic_url

  #relationships
  belongs_to :region
  belongs_to :rank
  belongs_to :brand

  has_many :containers
  has_many :cups, through: :containers
  has_many :vinifications
  has_many :grapes, through: :vinifications
  has_many :reviews
  has_many :wishes
  has_many :checks
  has_many :products
  has_many :deals
  belongs_to :author, class_name: "User", foreign_key: 'author_id'

  #validations
  validates :name,
      presence: true
  validates_presence_of :type

  TYPES = %w[Wine Whisky Vodka Tequila Rum Brandy Liqueur Gin Beer WhiteSpirit ChineseLiqueur RiceWine Sake]

  def self.types
    TYPES.map{|t| [t, I18n.t("beverages.categories.#{t}")]}
  end

  def reviews_score
    98
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
