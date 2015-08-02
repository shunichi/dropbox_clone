class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.string :access_token, null: false

      t.timestamps null: false
    end

    add_reference :shares, :inode, index: true, foreign_key: true
  end
end
