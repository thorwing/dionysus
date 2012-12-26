namespace :dionysus do
  desc "db:drop then db:seed"
  task :reset => :environment do
    begin
      Rake::Task['db:drop'].invoke
    rescue StandardError => ex_msg
      p ex_msg
    end
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    puts "Starting seeds."
    Rake::Task['db:seed'].invoke
    puts "The database has been reset."
  end
end