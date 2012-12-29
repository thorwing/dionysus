class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :body
      t.string :body_html
      t.datetime :replied_at
      t.integer :replies_count, default: 0
      t.integer :last_active_mark
      t.integer :last_reply_id

      t.integer :author_id
      t.integer :node_id

      t.timestamps
    end
  end
end
