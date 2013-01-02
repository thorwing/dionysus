class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.float :price
      t.integer :currency
      t.string :source
      t.string :source_id
      t.text :source_url

      t.integer :beverage_id

      t.timestamps
    end
  end
end
