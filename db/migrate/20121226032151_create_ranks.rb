class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :name
      t.string :trans_name
      t.string :category

      t.timestamps
    end
  end
end
