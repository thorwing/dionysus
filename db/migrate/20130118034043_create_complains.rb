class CreateComplains < ActiveRecord::Migration
  def change
    create_table :complains do |t|
      t.string :remark
      t.boolean :is_ignored, default: false
      t.boolean :is_solved, default: false

      t.integer :author_id
      t.references :complainable, :polymorphic => true

      t.timestamps
    end
    add_index :complains, [:complainable_id, :complainable_type]
  end
end
