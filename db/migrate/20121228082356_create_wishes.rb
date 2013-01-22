class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.string :remark
      t.boolean :accomplished, default: false
      t.integer :rating

      t.integer :user_id
      t.integer :beverage_id

      t.timestamps
    end
  end
end
