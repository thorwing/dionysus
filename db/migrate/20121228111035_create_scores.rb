class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :type
      t.string :points

      t.integer :review_id

      t.timestamps
    end
  end
end
