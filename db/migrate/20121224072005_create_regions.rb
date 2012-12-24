class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :en_name
      t.string :cn_name
      t.string :ancestry

      t.integer :country_id

      t.timestamps
    end

    add_index :regions, :ancestry
  end
end
