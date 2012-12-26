class CreateWhiskies < ActiveRecord::Migration
  def change
    create_table :whiskies do |t|

      t.timestamps
    end
  end
end
