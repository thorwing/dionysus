class Beverage < ActiveRecord::Base
  attr_accessible :en_title, :cn_title, :volume, :alcohol, :pic_url

  #relationships
  belongs_to :region
  belongs_to :rank
  belongs_to :brand

  has_many :containers
  has_many :cups, through: :containers
  has_many :vinifications
  has_many :grapes, through: :vinifications

  def full_name
    "#{en_title} / #{cn_title}"
  end
end
