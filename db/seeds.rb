# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# encoding: utf-8

#@admin = User.create!(nick: "admin", email: "admin@jujiu.us", password: "Iam1admin!", remote_avatar_url: upyun_url + 'sheldon.jpg', gender: "M") do |admin|
#  admin.role = ADMIN_ROLE
#end

p "generating countries"
records = YAML::load(File.open("db/seeds/countries.yml"))
records.each do |record|
  Country.create! do |country|
    country.name = record
  end
end

p "generating regions"
regions = YAML::load(File.open("db/seeds/regions.yml"))
regions.each do |r|
  region = Region.new do |new_region|
    new_region.en_name = r['en_name']
    new_region.cn_name = r['cn_name']
  end
  if r["parent"].present?
    region.parent = Region.find_by_en_name(r['parent'])
  end
  region.country = Country.find_by_name(r["country"])
  region.save!
end

p "generating ranks"
ranks = YAML::load(File.open("db/seeds/ranks.yml"))
ranks.each do |r|
  #rank = Rank.new(Rank.accessible_attributes & r)
  rank = Rank.new do |new_rank|
    new_rank.en_name = r['en_name']
    new_rank.cn_name = r['cn_name']
    new_rank.category = r["category"]
  end
  rank.save!
end

p "generating aoc"
aocs = YAML::load(File.open("db/seeds/aoc.yml"))
aocs.each do |a|
  aoc = Aoc.new do |new_aoc|
    new_aoc.en_name = a['en_name']
    new_aoc.cn_name = a['cn_name']
  end
  aoc.save!
end

p "generating grapes"
records = YAML::load(File.open("db/seeds/grapes.yml"))
records.each do |record|
  Grape.create! do |grape|
    grape.name = record
  end
end

p 'generating wine'
records = YAML::load(File.open("db/seeds/wine.yml"))
records.each do |record|
  wine = Wine.new
  wine.attributes = record.slice(*Wine.accessible_attributes)
  wine.region = Region.find_by_en_name(record["region"])
  wine.rank = Rank.find_by_en_name(record["rank"]) if record['rank'].present?
  wine.aoc = Aoc.find_by_en_name(record['aoc']) if record['aoc'].present?
  wine.grapes = Grape.where(name: record['grapes']) if record['grapes'].present?
  wine.save!
end

p 'generating beer'
records = YAML::load(File.open("db/seeds/beer.yml"))
records.each do |record|
  beer = Beer.new
  beer.attributes = record.slice(*Beer.accessible_attributes)
  beer.save!
end

p 'generating whisky'
records = YAML::load(File.open("db/seeds/whisky.yml"))
records.each do |record|
  whisky = Whisky.new
  whisky.attributes = record.slice(*Whisky.accessible_attributes)
  whisky.save!
end
