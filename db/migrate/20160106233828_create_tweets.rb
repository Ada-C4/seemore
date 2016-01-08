class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :creator_id
      t.string :posted_at
      t.string :url

      t.timestamps null: false
    end
  end
end
