class Rank < ActiveRecord::Base
  #relationships
  has_many :beverages

  def full_name
    "#{en_name} / #{cn_name}"
  end
end
