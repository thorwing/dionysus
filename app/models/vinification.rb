class Vinification < ActiveRecord::Base
  belongs_to :beverage
  belongs_to :grape
end
