class Recipe < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  attr_accessible  :name, :remark, :cocktail_id, :picture, :ingredients_attributes

  #relationships
  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  belongs_to :cocktail
  has_many :ingredients
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |i| i[:name].blank?}, :allow_destroy => true

  validates_presence_of :name
  validates_length_of :name, :maximum => 20
  validates_associated :ingredients
  validates_length_of :ingredients, :maximum => 16

  def self.text_search(query)
    where("name ILIKE :p", p: "%#{query}%")
  end

  attr_writer :current_stage
  def current_stage
    @current_stage || stages.first
  end

  def stages
    %w[naming detail]
  end

  def next_stage
    self.current_stage = stages[stages.index(current_stage)+1]
  end

  def previous_stage
    self.current_stage = stages[stages.index(current_stage)-1]
  end

  def first_stage?
    current_stage == stages.first
  end

  def last_stage?
    current_stage == stages.last
  end
end
