class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick
      t.integer :roles_mask
      t.string :locked_nodes_list

      t.timestamps
    end
  end
end
