class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :body
      t.integer :notable_id, null: false
      t.string :notable_type, null: false

      t.timestamps
    end

    add_index :notes, [:notable_id, :notable_type]
  end
end
