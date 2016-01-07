class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :twitter_id
      t.string :text
      t.string :uri

      t.timestamps null: false
    end
  end
end
