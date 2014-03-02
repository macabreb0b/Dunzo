class RemoveNotNullConstraintFromParentDeliverableId < ActiveRecord::Migration
  def change
    remove_column :deliverables, :parent_deliverable_id
    add_column :deliverables, :parent_deliverable_id, :integer
  end
end
