class CreateProducers < ActiveRecord::Migration
  def change
    create_table :producers do |t|

      t.integer :region_id

      t.timestamps
    end
  end
end
