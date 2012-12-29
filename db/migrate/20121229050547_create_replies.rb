class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :body
      t.string :body_html

      t.timestamps
    end
  end
end
