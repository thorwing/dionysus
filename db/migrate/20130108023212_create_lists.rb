class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.text :description

      t.integer :author_id

      t.timestamps
    end

    add_index :lists, :author_id
  end
end
