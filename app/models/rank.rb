class Rank < ActiveRecord::Base
  include Translatable
  has_ancestry
  acts_as_taggable_on :types
  attr_accessible :name, :trans_name, :type_list

  #relationships
  has_many :beverages
end
