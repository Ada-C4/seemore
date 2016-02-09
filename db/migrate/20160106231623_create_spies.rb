class CreateSpies < ActiveRecord::Migration
  def change
    create_table :spies do |t|
      t.string :uid
      t.string :username
      t.string :image_url
      t.string :provider

      t.timestamps null: false
    end
  end
end
