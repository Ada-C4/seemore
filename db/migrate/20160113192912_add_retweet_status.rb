class AddRetweetStatus < ActiveRecord::Migration
  def change
    add_column :media, :retweet_status, :string
  end
end
