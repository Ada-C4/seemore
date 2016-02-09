class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.string :username
      t.string :name
      t.string :image_url
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end
  end
end
