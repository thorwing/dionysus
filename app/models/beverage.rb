class Beverage < ActiveRecord::Base
  attr_accessible :en_name, :cn_name, :volume, :alcohol, :pic_url

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

  def full_name
    "#{en_name} / #{cn_name}"
  end

  def reviews_score
    98
  end

end
