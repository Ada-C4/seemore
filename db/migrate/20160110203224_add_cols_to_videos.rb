class AddColsToVideos < ActiveRecord::Migration
  def change
    add_column(:videos, :uri, :string)
    add_column(:videos, :name, :string)
    add_column(:videos, :embed, :string)
    add_column(:videos, :vimeo_id, :string)
    add_column(:videos, :description, :string)
  end
end
