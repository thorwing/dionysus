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
countries = YAML::load(File.open("db/seeds/countries.yml"))
countries.each do |c|
  Country.create! do |country|
    country.name = c
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

p "generating categories"
categories = YAML::load(File.open("db/seeds/categories.yml"))
categories.each do |c|
  category = Category.new do |new_category|
    new_category.en_name= c["en_name"]
    new_category.cn_name= c["cn_name"]
  end
  category.parent = Category.find_by_en_name(c["parent"]) if c["parent"].present?
  category.save!
end

p "generating ranks"
ranks = YAML::load(File.open("db/seeds/ranks.yml"))
ranks.each do |r|
  #rank = Rank.new(Rank.accessible_attributes & r)
  rank = Rank.new do |new_rank|
    new_rank.en_name = r['en_name']
    new_rank.cn_name = r['cn_name']
    new_rank.category = Category.find_by_en_name(r["category"]) if r["category"].present?
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


p "generating alcohols"
alcohols = YAML::load(File.open("db/seeds/alcohols.yml"))
alcohols.each do |a|
  alcohol = Alcohol.new
  alcohol.attributes = a.slice(*Alcohol.accessible_attributes)
  alcohol.region = Region.find_by_en_name(a["region"])
  alcohol.rank = Rank.find_by_en_name(a["rank"]) if a['rank'].present?
  alcohol.aoc = Aoc.find_by_en_name(a['aoc']) if a['aoc'].present?
  alcohol.save!
end

