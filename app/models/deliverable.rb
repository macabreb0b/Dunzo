# == Schema Information
#
# Table name: deliverables
#
#  id                    :integer          not null, primary key
#  project_id            :integer
#  name                  :string(255)      not null
#  created_at            :datetime
#  updated_at            :datetime
#  parent_deliverable_id :integer
#  completed             :boolean
#  hourly                :integer
#

class Deliverable < ActiveRecord::Base
  validates :project, :name, :presence => true
  validates :completed, :inclusion => { in: [true, false] }
  belongs_to :project
  has_many :hours, :dependent => :destroy, inverse_of: :deliverable

  before_validation :incomplete_by_default

  belongs_to :parent_deliverable,
    primary_key: :id,
    foreign_key: :parent_deliverable_id,
    class_name: "Deliverable"

  has_many :children,
    primary_key: :id,
    foreign_key: :parent_deliverable_id,
    class_name: "Deliverable"

  has_many :notes,
    primary_key: :id,
    foreign_key: :notable_id,
    class_name: "Note",
    dependent: :destroy

  def hour_count
    self.hours.count
  end

  def incomplete_by_default
    self.completed = false if self.completed.nil?
    true
  end
end
