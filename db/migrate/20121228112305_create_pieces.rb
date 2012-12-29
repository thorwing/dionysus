class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :flavor
      t.integer :strength

      t.integer :review_id

      t.timestamps
    end
  end
end
