class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.integer :beverage_id
      t.integer :cup_id

      t.timestamps
    end

    add_index :containers, [:beverage_id, :cup_id]
    add_index :containers, [:cup_id, :beverage_id]
  end
end
