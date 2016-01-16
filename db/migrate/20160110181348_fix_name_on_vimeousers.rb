class FixNameOnVimeousers < ActiveRecord::Migration
  def change
    change_table :vimeo_users do |t|
    remove_column :vimeo_users, :naame, :string
    add_column :vimeo_users, :name, :string
    end
  end
end
