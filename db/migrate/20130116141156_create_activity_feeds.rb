class CreateActivityFeeds < ActiveRecord::Migration
  def change
    create_table :activity_feeds do |t|
      t.string :type
      t.text :data

      t.references :user
      t.datetime :created_at

      t.timestamps
    end
  end
end
