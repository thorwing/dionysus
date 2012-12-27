class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :nick
      t.string :password_hash
      t.string :password_salt
      t.string :auth_token
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.integer :role, default: NORMAL_USER_ROLE

      t.timestamps
    end
  end
end
