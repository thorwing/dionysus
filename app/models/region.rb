class Region < ActiveRecord::Base
  attr_accessible :parent_id, :en_name, :cn_name
  has_ancestry

  #relationships
  belongs_to :country
  has_many :alcohols

  def full_name
    "#{en_name} / #{cn_name}"
  end
end
