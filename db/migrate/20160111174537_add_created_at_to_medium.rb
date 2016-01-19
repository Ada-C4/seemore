class AddCreatedAtToMedium < ActiveRecord::Migration
  def change
    add_column :media, :tweet_time, :datetime
  end
end
