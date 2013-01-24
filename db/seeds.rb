# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# encoding: utf-8

p "generating users"
%w(admin author user merchant ).each do |people|
  User.find_or_create_by_email("#{people}@guanyu9.com") do |user|
    user.password = "guanyu9"
    user.role = people if User.roles.include? people
    user.nick = people
  end
end

p 'generating cities'
records = YAML::load(File.open("db/seeds/cities.yml"))
records.each do |record|
  city = City.new
  city.attributes = record.slice(*City.accessible_attributes)
  city.save!

  (record["areas"] || []).each do |r|
    area = Area.new
    area.attributes = r.slice(*Area.accessible_attributes)
    area.city = city
    area.parent = Area.find_by_code(r['parent']) if r['parent'].present?
    area.save!
  end
end

p "generating regions"
records_hash = YAML::load(File.open("db/seeds/regions.yml"))
records_hash.each do |beverage_type, records|
  records.each do |record|
    region = Region.new
    region.attributes = record.slice(*Region.accessible_attributes)
    region.parent = Region.find_by_name(record['parent']) if record["parent"].present?
    region.beverage_type = beverage_type
    region.save!
  end
end

p "generating ranks"
ranks = YAML::load(File.open("db/seeds/ranks.yml"))
ranks.each do |record|
  rank = Rank.new
  rank.attributes = record.slice(*Rank.accessible_attributes)
  rank.parent = Rank.find_by_name(record['parent']) if record["parent"].present?
  rank.save!
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
  %w(brand region rank).each do |association|
    beverage.send("#{association}=".to_sym, association.singularize.classify.constantize.find_by_name(record[association])) if record[association].present?
  end
  beverage.save!
end

p 'generating recipes'
records = YAML::load(File.open("db/seeds/recipes.yml"))
records.each do |record|
  recipe = Recipe.new
  recipe.attributes = record.slice(*Recipe.accessible_attributes)
  recipe.cocktail = Cocktail.find_or_create_by_name(recipe.name)
  recipe.author = User.first(conditions: {role: "user"})
  recipe.save!
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
  article.author = User.first(conditions: {role: "author"})
  article.attributes = record.slice(*Article.accessible_attributes)
  article.released_at = (1 + rand(3)).weeks.ago
  article.view_count = rand(100)
  article.save!
end