class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :user, index: true
      t.string :name, null: false
      t.string :email
      t.string :phone
      t.string :company

      t.timestamps
    end
  end
end
