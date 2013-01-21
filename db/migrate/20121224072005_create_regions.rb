class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :trans
      t.string :ancestry
      t.string :beverage_type

      t.timestamps
    end

    add_index :regions, :ancestry
  end
end
