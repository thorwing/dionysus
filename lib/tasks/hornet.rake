namespace :dionysus do
  desc "fetch whiskies"
  task :fetch_whiskies => :environment do
    Hornet::BeveragesHornet.new.fetch
  end
end

