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

require 'spec_helper'

describe Note do
  pending "add some examples to (or delete) #{__FILE__}"
end
