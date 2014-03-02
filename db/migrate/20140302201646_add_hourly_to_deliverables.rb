class AddHourlyToDeliverables < ActiveRecord::Migration
  def change
    add_column :deliverables, :hourly, :integer
  end
end
