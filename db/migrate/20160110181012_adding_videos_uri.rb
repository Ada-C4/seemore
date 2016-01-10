class AddingVideosUri < ActiveRecord::Migration
  def change
    change_table :vimeo_users do |t|
    add_column :vimeo_users, :videos_uri, :string
    end
  end
end
