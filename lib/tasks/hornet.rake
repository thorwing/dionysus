namespace :dionysus do
  desc "fetch whiskies"
  task :fetch_whiskies => :environment do
    SilverHornet::Hornet.fetch("WhiskyBase")
  end

  desc "fetch beers"
  task :fetch_beer => :environment do
    SilverHornet::Hornet.fetch("BeerAdvocate")
  end
end

