class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.integer :p_id
      t.string :provider
      t.string :avatar_url
      t.string :username

      t.timestamps null: false
    end
  end
end
