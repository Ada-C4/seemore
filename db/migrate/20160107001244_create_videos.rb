class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :creator_id
      t.string :posted_at
      t.string :url

      t.timestamps null: false
    end
  end
end
