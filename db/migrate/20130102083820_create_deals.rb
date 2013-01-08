class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :amount
      t.float :price
      t.string :remark

      t.integer :beverage_id
      t.integer :seller_id

      t.timestamps
    end
  end
end
