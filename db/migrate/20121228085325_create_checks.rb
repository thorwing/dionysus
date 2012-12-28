class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.string :remark

      t.integer :author_id
      t.integer :beverage_id

      t.integer :star

      t.timestamps
    end
  end
end
