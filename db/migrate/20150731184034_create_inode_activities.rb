class CreateInodeActivities < ActiveRecord::Migration
  def change
    create_table :inode_activities do |t|
      t.string :comment

      t.timestamps null: false
    end

    add_reference :inode_activities, :inode, index: true, foreign_key: true
  end
end
