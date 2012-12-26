class Category < ActiveRecord::Base
  attr_accessible :parent_id, :en_name, :cn_name
  has_ancestry

  #relationships
  has_many :alcohols
  has_many :ranks

end
