class Rank < ActiveRecord::Base
  #relationships
  has_many :alcohols
  belongs_to :category

  def full_name
    "#{en_name} / #{cn_name}"
  end
end
