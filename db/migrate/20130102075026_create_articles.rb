class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.datetime :released_at
      t.integer :view_count

      t.integer :author_id

      t.timestamps
    end
  end
end
