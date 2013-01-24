class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :body

      t.references :topic
      t.integer :author_id

      t.timestamps
    end
  end
end
