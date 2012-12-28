class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.string :remark

      t.integer :author_id
      t.integer :beverage_id

      t.timestamps
    end
  end
end
