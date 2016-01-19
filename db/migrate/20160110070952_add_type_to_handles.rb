class AddTypeToHandles < ActiveRecord::Migration
  def change
    add_column :handles, :type, :string
  end
end
