class Aoc < ActiveRecord::Base

  #relationships
  has_many :alcohols
  belongs_to :region


  def full_name
    "#{en_name} / #{cn_name}"
  end
end
