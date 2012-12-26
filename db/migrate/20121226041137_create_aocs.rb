class CreateAocs < ActiveRecord::Migration
  def change
    create_table :aocs do |t|
      t.string :en_name
      t.string :cn_name

      t.timestamps
    end
  end
end
