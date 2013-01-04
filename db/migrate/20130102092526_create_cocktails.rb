class CreateCocktails < ActiveRecord::Migration
  def change
    create_table :cocktails do |t|

      t.timestamps
    end
  end
end
