class UpdateHandlesTable < ActiveRecord::Migration
  def change
    remove_column :handles, :description
    remove_column :handles, :twitter_id
    add_column :handles, :link, :string
  end
end
