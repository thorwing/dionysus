class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities, {id: false} do |t|
      t.integer :code, primary: true
      t.string :name

      t.timestamps
    end
  end
end
