class CreateInstagramUsers < ActiveRecord::Migration
  def change
    create_table :instagram_users do |t|
      t.string :instagram_id
      t.string :screen_name
      t.string :name
      t.string :description
      t.string :uri
      t.string :profile_image_uri

      t.timestamps null: false
    end
  end
end
