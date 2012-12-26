class CreateAlcohols < ActiveRecord::Migration
  def change
    create_table :alcohols do |t|
      t.string :en_title
      t.string :cn_title
      t.integer :year
      t.integer :milliliter
      t.float :degree
      t.text :pic_url

      t.integer :region_id
      t.integer :category_id
      t.integer :producer_id
      t.integer :rank_id
      t.integer :aoc_id

      t.timestamps
    end
  end
end
