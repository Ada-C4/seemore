class AddTwitterUserIdToTweets < ActiveRecord::Migration
  def change
    add_column(:tweets, :twitter_user_id, :integer)
    add_index :tweets, :twitter_user_id
  end
end
