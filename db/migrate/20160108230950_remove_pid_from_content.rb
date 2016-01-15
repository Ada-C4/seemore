class RemovePidFromContent < ActiveRecord::Migration
  def change
    remove_column :contents, :p_id
    add_column :contents, :creator_id, :integer
    add_index :contents, :creator_id
  end
end
