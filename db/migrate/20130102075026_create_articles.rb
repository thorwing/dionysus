class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :body
      t.string :body_html

      t.integer :author_id

      t.timestamps
    end
  end
end
