# == Schema Information
#
# Table name: inode_activities
#
#  id         :integer          not null, primary key
#  comment    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  inode_id   :integer
#
# Indexes
#
#  index_inode_activities_on_inode_id  (inode_id)
#

class InodeActivity < ActiveRecord::Base
  belongs_to :inode
end
