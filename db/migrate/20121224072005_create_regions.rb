class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :trans_name
      t.string :ancestry

      t.integer :country_id

      t.timestamps
    end

    add_index :regions, :ancestry
  end
end
