# == Schema Information
#
# Table name: inodes
#
#  id           :integer          not null, primary key
#  name         :string
#  inode_type   :string
#  content      :string
#  content_type :string
#  file_size    :integer
#  ancestry     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_inodes_on_ancestry  (ancestry)
#

class Inode < ActiveRecord::Base
  extend Enumerize
  has_ancestry
  acts_as_followable

  enumerize :inode_type, in: %w(file directory), predicates: true
  default_value_for :inode_type, 'file'

  mount_uploader :content, FileUploader

  validates :name, presence: true
  validates :content, presence: true, if: :file?

  has_one :user, dependent: :restrict_with_error
  has_many :inode_activities
  has_many :shares

  before_validation :update_content_attributes
  after_create :create_add_activity
  after_destroy :create_remove_activity

  def image?
    self.content_type.present? && ( self.content_type.start_with? 'image' )
  end

  private

  def update_content_attributes
    if content.present? && content_changed?
      self.name = content.filename
      self.content_type = content.file.content_type
      self.file_size = content.file.size
    end
  end

  def create_add_activity
    self.parent.inode_activities.create!(comment: "add #{self.inode_type}: #{self.name}") if self.parent
  end

  def create_remove_activity
    begin
      self.parent.inode_activities.create!(comment: "remove #{self.inode_type}: #{self.name}") if self.parent
    rescue ActiveRecord::RecordNotFound => _e
    end
  end
end
