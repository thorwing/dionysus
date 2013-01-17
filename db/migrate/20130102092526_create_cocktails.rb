class CreateCocktails < ActiveRecord::Migration
  def change
    create_table :cocktails do |t|
      t.string :name
      t.string :trans_name

      t.timestamps
    end
  end
end
