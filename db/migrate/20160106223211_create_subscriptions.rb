class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :username
      t.string :uid
      t.string :provider
      t.string :avatar_url

      t.timestamps null: false
    end
  end
end
