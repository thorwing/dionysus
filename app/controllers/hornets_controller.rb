class HornetsController < ApplicationController
  def index

  end

  def fetch
    case params["type"]
      when "whisky"
        SilverHornet::Hornet.fetch("WhiskyBase")
      when "beer"
        SilverHornet::Hornet.fetch("BeerAdvocate")
    end
  end

end
