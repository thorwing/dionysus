class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :en_name
      t.string :cn_name
      t.string :category_id

      t.timestamps
    end
  end
end
