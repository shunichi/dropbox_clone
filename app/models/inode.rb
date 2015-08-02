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
  attr_accessor :original_inode_id

  enumerize :inode_type, in: %w(file directory), predicates: true
  default_value_for :inode_type, 'file'

  mount_uploader :content, FileUploader

  validates :name, presence: true
  validates :content, presence: true, if: :file?
  validates :file_size, numericality: { less_than_or_equal_to: 0.5.megabytes.to_i }, if: :file?

  has_one :user, dependent: :restrict_with_error
  has_many :inode_activities
  has_many :shares

  before_validation :update_content_attributes
  after_create :create_add_activity
  after_destroy :create_remove_activity

  def image?
    self.content_type.present? && ( self.content_type.start_with? 'image' )
  end

  def include?(inode)
    self == inode || self.subtree.exists?(id: inode.id)
  end

  private

  def update_content_attributes
    self.content = File.open(Rails.root.join('uploads', original_inode_id, name)) if original_inode_id

    if content.present? && content_changed?
      self.name = content.filename
      self.content_type = content.file.content_type
      self.file_size = content.file.size
    end
  end

  def create_add_activity
    create_activity("add #{self.inode_type}: #{self.name}")
  end

  def create_remove_activity
    create_activity("remove #{self.inode_type}: #{self.name}")
  end

  def create_activity(comment)
    begin
      self.parent.inode_activities.create!(comment: comment) if self.parent
    rescue ActiveRecord::RecordNotFound => _e
    end
  end
end
