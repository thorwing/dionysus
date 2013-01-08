class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :list_id
      t.integer :beverage_id
      t.string :remark

      t.timestamps
    end

    add_index :packages, [:list_id, :beverage_id]
    add_index :packages, [:beverage_id, :list_id]
  end
end
