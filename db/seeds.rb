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

p "generating alcohols"
alcohols = YAML::load(File.open("db/seeds/alcohols.yml"))
alcohols.each do |a|
  alcohol = Alcohol.new do |new_alcohol|
    new_alcohol.en_title = a["en_title"]
    new_alcohol.cn_title = a["cn_title"]
    new_alcohol.aoc = a["aoc"]
    new_alcohol.aoc_level = a["aoc_level"]
    new_alcohol.milliliter = a["milliliter"]
    new_alcohol.year = a["year"]
    new_alcohol.degree = a["degree"]
    new_alcohol.pic_url = a["pic_url"]
  end
  alcohol.region = Region.find_by_en_name(a["region"])
  alcohol.save!
end
