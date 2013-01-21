class Wine < Beverage
  attr_accessible :color, :sweetness

  def self.colors
    %w(red white rose)
  end

  def self.sweetness
    %w(dry half_dry half_sweet sweet)
  end

end
