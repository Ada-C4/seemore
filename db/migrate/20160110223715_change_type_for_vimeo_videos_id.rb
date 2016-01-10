class ChangeTypeForVimeoVideosId < ActiveRecord::Migration
  def change
    change_table :videos do |t|
    remove_column :videos, :vimeo_video_id, :integer
    add_column :videos, :vimeo_video_id, :string
    end
  end
end
