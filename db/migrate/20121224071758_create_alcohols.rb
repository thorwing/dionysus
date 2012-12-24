class CreateAlcohols < ActiveRecord::Migration
  def change
    create_table :alcohols do |t|
      t.string :en_title
      t.string :cn_title
      t.string :aoc
      t.string :aoc_level
      t.integer :year
      t.integer :milliliter
      t.float :degree
      t.text :pic_url

      t.integer :region_id
      t.integer :category_id
      t.integer :producer_id

      t.timestamps
    end
  end
end
