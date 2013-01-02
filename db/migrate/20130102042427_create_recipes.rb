class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :remark
      t.text :pic_url

      t.integer :author_id

      t.timestamps
    end
  end
end
