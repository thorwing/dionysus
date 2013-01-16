class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :trans_name
      t.string :type_list
      t.string :ancestry

      t.references :country

      t.timestamps
    end

    add_index :regions, :ancestry
  end
end
