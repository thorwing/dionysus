class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :remark
      t.string :picture

      t.integer :author_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
