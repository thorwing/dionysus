class CreateVinifications < ActiveRecord::Migration
  def change
    create_table :vinifications do |t|
      t.integer :alcohol_id
      t.integer :ingredient_id

      t.timestamps
    end

    add_index :vinifications, [:alcohol_id, :ingredient_id]
    add_index :vinifications, [:ingredient_id, :alcohol_id]
  end
end
