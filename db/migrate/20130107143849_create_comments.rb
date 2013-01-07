class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.string :ancestry

      t.integer :author_id
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end

    add_index :comments, :ancestry
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
