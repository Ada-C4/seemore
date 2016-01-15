class Create < ActiveRecord::Migration
  def change
    create_table :users_vimeo_users, id: false do |t|
      t.belongs_to :vimeo_user, index: true
      t.belongs_to :user, index: true
    end
  end
end
