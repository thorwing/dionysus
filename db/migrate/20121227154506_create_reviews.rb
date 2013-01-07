class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.integer :score
      t.integer :nose_score
      t.string :nose_list
      t.integer :taste_score
      t.string :taste_list
      t.integer :finish_score
      t.string :finish_list
      t.integer :balance_score
      t.string :balance_list

      t.string :food_list

      t.integer :up_votes, null: false, default: 0
      t.integer :down_votes, null: false, default: 0

      t.integer :author_id
      t.integer :beverage_id

      t.timestamps
    end
  end
end
