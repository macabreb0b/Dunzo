# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)      not null
#  email      :string(255)
#  phone      :string(255)
#  company    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Client < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :user
  has_many :projects, dependent: :destroy

  def to_s
    "#{self.name} at #{self.company}"
  end
end
