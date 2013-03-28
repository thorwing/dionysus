class Beverage < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  include Translatable
  acts_as_taggable_on :grapes
  attr_accessible :type, :name, :trans, :brand_id, :region_id, :style, :vintage, :volume, :alcohol, :year, :grape_list, :picture, :remote_picture_url, :bottler, :distillation_method, :barrel_cask, :age, :color, :sweetness, :rank_id

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
  has_many :complains, as: :complainable

  #validations
  validates :name,
      presence: true
  validates_presence_of :type

  TYPES = %w[Wine Whisky Vodka Tequila Rum Brandy Liqueur Gin Beer WhiteSpirit ChineseLiqueur RiceWine Sake]

  def self.styles
    []
  end

  def self.vintages
    Date.today.year.downto(1980).to_a | [-1]
  end

  def self.text_search(query)
    where("name ILIKE :p OR trans ILIKE :p", p: "%#{query}%")
  end

  def self.types
    TYPES.map{|t| [t, I18n.t("beverages.categories.#{t}")]}
  end

  def reviews_score
    reviews.first.try(:score) || I18n.t("reviews.score_na")
  end

  def rating
    wishes.empty? ? 0 : format('%.1f', wishes.sum(&:rating).to_f / wishes.size.to_f)
  end

  #TODO stub
  def tags(limit = 3)
    self.wishes.tag_counts_on(:tags).order("count DESC").limit(limit)
  end

  #TODO stub
  def get_picture(version = nil)
    if picture?
      picture_url(version)
    else
      'default_beverage.png'
    end
  end

end
