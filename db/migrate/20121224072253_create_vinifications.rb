class CreateVinifications < ActiveRecord::Migration
  def change
    create_table :vinifications do |t|
      t.integer :beverage_id
      t.integer :ingredient_id

      t.timestamps
    end

    add_index :vinifications, [:beverage_id, :ingredient_id]
    add_index :vinifications, [:ingredient_id, :beverage_id]
  end
end
