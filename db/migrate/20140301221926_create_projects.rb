class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :client, index: true, null: false
      t.references :user, index: true, null: false
      t.string :name, null: false
      t.boolean :open, null: false
      t.string :description

      t.timestamps
    end
  end
end
