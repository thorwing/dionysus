class CreateVinifications < ActiveRecord::Migration
  def change
    create_table :vinifications do |t|
      t.integer :beverage_id
      t.integer :grape_id

      t.timestamps
    end

    add_index :vinifications, [:beverage_id, :grape_id]
    add_index :vinifications, [:grape_id, :beverage_id]
  end
end
