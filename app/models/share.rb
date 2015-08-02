# == Schema Information
#
# Table name: shares
#
#  id           :integer          not null, primary key
#  access_token :string           not null
#  email        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  inode_id     :integer
#
# Indexes
#
#  index_shares_on_inode_id  (inode_id)
#

class Share < ActiveRecord::Base
  belongs_to :inode

  def session_key
    "share_#{self.id}"
  end

  default_value_for :access_token do
    SecureRandom.hex(16)
  end
end
