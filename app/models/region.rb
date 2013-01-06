class Region < ActiveRecord::Base
  include Translatable
  attr_accessible :parent_id, :en_name, :cn_name
  has_ancestry

  #relationships
  belongs_to :country
  has_many :beverages
  has_many :aocs

end
