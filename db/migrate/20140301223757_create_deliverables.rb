class CreateDeliverables < ActiveRecord::Migration
  def change
    create_table :deliverables do |t|
      t.references :project, index: true
      t.integer :parent_deliverable_id, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
