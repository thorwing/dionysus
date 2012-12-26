class Alcohol < ActiveRecord::Base
  attr_accessible :en_title, :cn_title, :year, :milliliter, :degree, :pic_url

  #relationships
  belongs_to :region
  belongs_to :category
  belongs_to :rank
  belongs_to :aoc

  def full_name
    "#{en_title} / #{cn_title}"
  end
end
