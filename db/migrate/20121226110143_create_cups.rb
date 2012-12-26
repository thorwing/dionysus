class CreateCups < ActiveRecord::Migration
  def change
    create_table :cups do |t|

      t.timestamps
    end
  end
end
