class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :name
      t.string :trans
      t.string :type_list
      t.string :ancestry

      t.timestamps
    end
  end
end
