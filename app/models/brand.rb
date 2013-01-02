class Brand < ActiveRecord::Base
  attr_accessible :en_name, :cn_name

  #relationships
  has_many :beverages

  #validations
  validates :en_name,
    presence: true,
    uniqueness: true

  #validates :cn_name,
  #  presence: true,
  #  uniqueness: true

  def full_name
    "#{en_name} / #{cn_name}"
  end
end
