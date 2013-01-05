class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.text :body_html
      t.datetime :released_at

      t.integer :author_id

      t.timestamps
    end
  end
end
