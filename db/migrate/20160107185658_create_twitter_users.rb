class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.integer :twitter_id
      t.string :screen_name
      t.string :name
      t.string :description
      t.string :location
      t.string :uri
      t.string :profile_image_uri

      t.timestamps null: false
    end
  end
end
