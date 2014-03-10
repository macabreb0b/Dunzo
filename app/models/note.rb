# == Schema Information
#
# Table name: notes
#
#  id           :integer          not null, primary key
#  body         :text
#  notable_id   :integer          not null
#  notable_type :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Note < ActiveRecord::Base
  belongs_to :notable, polymorphic: true

end
