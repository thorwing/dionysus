class Aoc < ActiveRecord::Base

  #relationships
  has_many :beverages
  belongs_to :region


  def full_name
    "#{en_name} / #{cn_name}"
  end
end
