class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude

      t.references :city
      t.references :area
      t.references :locationable, :polymorphic => true

      t.timestamps
    end

    add_index :locations, [:locationable_id, :locationable_type]
  end
end
