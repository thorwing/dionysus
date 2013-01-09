ActiveAdmin.register Beverage do
  #scope :unproved

  index do
    column :full_name do |beverage|
      link_to beverage.name, beverage
    end
    column :type
    column :info do |beverage|
      "#{beverage.alcohol} #{beverage.volume}"
    end
    #column :approved
    default_actions
  end
end
