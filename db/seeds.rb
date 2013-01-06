# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# encoding: utf-8

p "generating users"
tester = User.create!(email: "tester@guanyu9.com", password: "guanyu9") do |user|
  user.roles = %w(author)
  user.nick = "tester"
end

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
    new_region.name = r['en_name']
    new_region.trans_name = r['trans_name']
  end
  if r["parent"].present?
    region.parent = Region.find_by_name(r['parent'])
  end
  region.country = Country.find_by_name(r["country"])
  region.save!
end

p "generating ranks"
ranks = YAML::load(File.open("db/seeds/ranks.yml"))
ranks.each do |r|
  #rank = Rank.new(Rank.accessible_attributes & r)
  rank = Rank.new do |new_rank|
    new_rank.name = r['name']
    new_rank.trans_name = r['trans_name']
    new_rank.category = r["category"]
  end
  rank.save!
end

p "generating aoc"
aocs = YAML::load(File.open("db/seeds/aoc.yml"))
aocs.each do |a|
  aoc = Aoc.new do |new_aoc|
    new_aoc.name = a['name']
    new_aoc.trans_name = a['trans_name']
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

p "generating brands"
records = YAML::load(File.open("db/seeds/brands.yml"))
records.each do |record|
  brand = Brand.new
  brand.attributes = record.slice(*Brand.accessible_attributes)
  brand.save!
end

p 'generating beverages'
records = YAML::load(File.open("db/seeds/beverages.yml"))
records.each do |record|
  klass = record['type'].singularize.classify.constantize
  beverage = klass.new
  beverage.attributes = record.slice(*klass.accessible_attributes)
  %w(brand region rank aoc).each do |association|
    beverage.send("#{association}=".to_sym, association.singularize.classify.constantize.find_by_name(record[association])) if record[association].present?
  end
  #for wine
  beverage.grapes = Grape.where(name: record['grapes']) if record['grapes'].present?
  beverage.save!
end

p 'generating cocktails'
records = YAML::load(File.open("db/seeds/cocktails.yml"))
records.each do |record|
  brand = Recipe.new
  brand.attributes = record.slice(*Recipe.accessible_attributes)
  brand.save!
end

p 'generating nodes'
records = YAML::load(File.open("db/seeds/nodes.yml"))
records.each do |record|
  Node.create! do |node|
    node.name = record
  end
end

p 'generating articles'
records = YAML::load(File.open("db/seeds/articles.yml"))
records.each do |record|
  article = Article.new
  article.author = tester
  article.attributes = record.slice(*Article.accessible_attributes)
  article.released_at = (1 + rand(3)).weeks.ago
  article.view_count = rand(100)
  article.save!
end