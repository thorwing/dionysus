class CreateGrapes < ActiveRecord::Migration
  def change
    create_table :grapes do |t|
      t.string :name

      t.timestamps
    end
  end
end
