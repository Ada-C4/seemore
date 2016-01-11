class AddVimeoVideoIdToVideo < ActiveRecord::Migration
  def change
    add_column(:videos, :vimeo_video_id, :integer)
  end
end
