class UpdateMediaTable < ActiveRecord::Migration
  def change
    remove_column :media, :type
    remove_column :media, :text
    rename_column :media, :tweet_time, :posted_at
  end
end
