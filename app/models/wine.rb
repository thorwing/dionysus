class Wine < Beverage
  attr_accessible :color, :sweetness, :rank_id

  def self.styles
    %w(still_wine sparkling_wine champagne sherry port)
  end

  def self.colors
    %w(red white rose)
  end

  def self.sweetness
    %w(dry half_dry half_sweet sweet)
  end

end
