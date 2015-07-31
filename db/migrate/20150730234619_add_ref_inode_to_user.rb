class AddRefInodeToUser < ActiveRecord::Migration
  def change
    add_reference :users, :inode, index: true, foreign_key: true
  end
end
