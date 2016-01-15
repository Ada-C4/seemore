class RemoveUrlFromTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :url, :string
  end
end
