class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :remark
      t.string :picture

      t.references :cocktail
      t.integer :author_id

      t.timestamps
    end
  end
end
