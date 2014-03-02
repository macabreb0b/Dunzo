class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.string :body, null: false
      t.integer :requireable_id, null: false
      t.string :requireable_type, null: false

      t.timestamps
    end

    add_index :requirements, [:requireable_id, :requireable_type]
  end
end
