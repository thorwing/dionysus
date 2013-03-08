class CreateBeverages < ActiveRecord::Migration
  def change
    create_table :beverages do |t|
      t.string :type
      t.string :name
      t.string :trans
      t.string :alcohol
      t.string :volume
      t.string :bottler
      t.string :distillation_method
      t.string :barrel_cask
      t.string :style
      t.string :color
      t.string :sweetness
      t.string :vintage
      t.string :age
      t.string :picture
      t.string :grape_list

      t.references :region
      t.references :brand
      t.references :rank

      t.integer :author_id

      t.timestamps
    end
  end
end
