class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.integer :score

      t.integer :author_id
      t.integer :beverage_id

      t.timestamps
    end
  end
end
