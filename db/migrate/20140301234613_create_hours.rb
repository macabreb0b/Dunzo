class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.references :deliverable, index: true
      t.boolean :invoiced

      t.timestamps
    end
  end
end
