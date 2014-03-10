# == Schema Information
#
# Table name: requirements
#
#  id               :integer          not null, primary key
#  body             :string(255)      not null
#  requireable_id   :integer          not null
#  requireable_type :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Requirement do
  pending "add some examples to (or delete) #{__FILE__}"
end
