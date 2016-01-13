class AddRetweetStatus < ActiveRecord::Migration
  def change
    add_column :media, :retweeted_from, :string
    add_column :media, :retweeted_from_link, :string
  end
end
