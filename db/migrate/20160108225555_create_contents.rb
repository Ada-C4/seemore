class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :content_id
      t.string :text
      t.string :create_time
      t.integer :favorites
      t.string :embed_code
      t.integer :retweet_count
      t.integer :p_id

      t.timestamps null: false
    end
    add_index :contents, :p_id
  end
end
