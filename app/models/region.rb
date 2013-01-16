class Region < ActiveRecord::Base
  include Translatable
  attr_accessible :parent_id, :name, :trans_name, :type_list
  has_ancestry
  acts_as_taggable_on :types

  #relationships
  belongs_to :country
  has_many :beverages

end
