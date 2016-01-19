class AddTwitterColumnsToHandleModel < ActiveRecord::Migration
  def change
    add_column :handles, :description, :string
    add_column :handles, :uri, :string
    add_column :handles, :profile_image_uri, :string
    add_column :handles, :twitter_id, :integer, :limit => 8
  end
end
