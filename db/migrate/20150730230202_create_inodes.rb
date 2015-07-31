class CreateInodes < ActiveRecord::Migration
  def change
    create_table :inodes do |t|
      t.string :name
      t.string :inode_type

      t.string :content
      t.string :content_type
      t.integer :file_size

      t.string :ancestry, index: true

      t.timestamps null: false
    end
  end
end
