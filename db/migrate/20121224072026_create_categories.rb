class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :en_name
      t.string :cn_name
      t.string :ancestry

      t.timestamps
    end
  end
end
