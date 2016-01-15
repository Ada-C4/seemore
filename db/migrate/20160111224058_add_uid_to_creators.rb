class AddUidToCreators < ActiveRecord::Migration
  def change
    add_column :creators, :uid, :string
  end
end
