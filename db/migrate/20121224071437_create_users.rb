class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick
      t.string :role
      t.string :locked_nodes_list

      t.timestamps
    end
  end
end
