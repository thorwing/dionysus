class CreateBeverages < ActiveRecord::Migration
  def change
    create_table :beverages do |t|
      t.string :type
      t.string :name
      t.string :trans_name
      t.string :alcohol
      t.string :volume
      t.string :bottler
      t.string :distillation_method
      t.string :barrel_cask
      t.string :style
      t.string :sub_style
      t.string :vintage
      t.string :age
      t.string :picture
      t.text :pic_url
      t.string :grape_list

      t.integer :region_id
      t.integer :brand_id
      t.integer :rank_id
      #wine
      t.integer :aoc_id

      t.integer :author_id

      t.timestamps
    end
  end
end
