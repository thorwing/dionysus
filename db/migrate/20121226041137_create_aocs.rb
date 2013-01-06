class CreateAocs < ActiveRecord::Migration
  def change
    create_table :aocs do |t|
      t.string :name
      t.string :trans_name

      t.timestamps
    end
  end
end
