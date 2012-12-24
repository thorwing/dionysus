class Alcohol < ActiveRecord::Base
  attr_accessible :en_title, :cn_title, :aoc, :aoc_level, :year, :milliliter, :degree, :pic_url

  #relationships
  belongs_to :region

  def full_name
    "#{en_title} / #{cn_title}"
  end
end
