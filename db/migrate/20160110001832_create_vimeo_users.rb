class CreateVimeoUsers < ActiveRecord::Migration
  def change
    create_table :vimeo_users do |t|
      t.string :naame
      t.string :description
      t.string :location
      t.string :uri
      t.string :profile_image_uri

      t.timestamps null: false
    end
  end
end
