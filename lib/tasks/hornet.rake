namespace :dionysus do
  desc "fetch whiskies"
  task :fetch_whiskies => :environment do
    SilverHornet::Hornet.fetch("TheWhiskyExchange")
  end
end

