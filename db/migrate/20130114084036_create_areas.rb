class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas, {id: false} do |t|
      t.integer :code, primary: true
      t.string :name
      t.string :ancestry

      t.integer :city_code

      t.timestamps
    end

    add_index :areas, :ancestry
  end
end
