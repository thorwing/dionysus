class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :trans
      t.string :type_list

      t.timestamps
    end
  end
end
