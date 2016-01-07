class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :uid
      t.string :text
      t.string :url
      t.integer :subscription_id
      t.string :post_time

      t.timestamps null: false
    end
  end
end
