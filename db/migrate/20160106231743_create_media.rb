class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :mark_id
      t.string :media_url
      t.string :date_posted
      t.string :text
      t.string :location
      t.string :link
      t.string :medium_type

      t.timestamps null: false
    end
  end
end
