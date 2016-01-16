class PluralizeProfilePicturesUri < ActiveRecord::Migration
  def change
    change_table :vimeo_users do |t|
    remove_column :vimeo_users, :profile_image_uri, :string
    add_column :vimeo_users, :profile_images_uri, :string
    end
  end
end
