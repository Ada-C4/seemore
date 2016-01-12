class AddUniqueMediaId < ActiveRecord::Migration
  def change
    add_column :media, :uid, :string
  end
end
