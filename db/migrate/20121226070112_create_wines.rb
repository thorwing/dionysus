class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|

      t.timestamps
    end
  end
end
