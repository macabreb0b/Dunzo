# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  client_id   :integer          not null
#  user_id     :integer          not null
#  name        :string(255)      not null
#  open        :boolean          not null
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Project < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :client
  belongs_to :user

  has_many :deliverables, dependent: :destroy, inverse_of: :project
  has_many :hours, through: :deliverables
  has_many :notes,
    primary_key: :id,
    foreign_key: :notable_id,
    class_name: "Note"

  def hour_count
    self.hours.count
  end

  def invoiced_hours
    self.hours.where(:invoiced => true).count
  end

  def uninvoiced_hours
    self.hours.where(:invoiced => false).count
  end
end
