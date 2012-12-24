namespace :dionysus do
  desc "db:drop then db:seed"
  task :reset => :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    puts "Starting seeds."
    Rake::Task['db:seed'].invoke
    puts "The database has been reset."
  end
end