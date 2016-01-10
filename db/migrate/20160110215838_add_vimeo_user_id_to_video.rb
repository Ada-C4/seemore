class AddVimeoUserIdToVideo < ActiveRecord::Migration
  def change
    add_column(:videos, :vimeo_user_id, :integer)
    add_index :videos, :vimeo_user_id
  end
end
