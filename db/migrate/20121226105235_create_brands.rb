class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :trans_name

      t.timestamps
    end
  end
end
