class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.string :name
      t.string :profile_pic
      t.string :description
      t.string :provider

      t.timestamps null: false
    end
  end
end
