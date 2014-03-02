# == Schema Information
#
# Table name: hours
#
#  id             :integer          not null, primary key
#  deliverable_id :integer
#  invoiced       :boolean
#  created_at     :datetime
#  updated_at     :datetime
#

class Hour < ActiveRecord::Base
  validates :deliverable, :presence => true
  validates :invoiced, :inclusion => { in: [true, false] }
  belongs_to :deliverable

  before_validation :not_invoiced_by_default

  def not_invoiced_by_default
    self.invoiced = false if self.invoiced.nil?
    true
  end
end
