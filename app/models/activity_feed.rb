class ActivityFeed < ActiveRecord::Base
  serialize :data, JSON
  attr_accessible :user_id, :type, :data

  belongs_to :user

  validates_presence_of :user

  def self.types
    %w[follow comment review sale list]
  end
end
