class AddCompletedColumnToDeliverables < ActiveRecord::Migration
  def change
    add_column :deliverables, :completed, :boolean
  end
end
