class ChangeTypeColumnNameInHandles < ActiveRecord::Migration
  def change
    rename_column :handles, :type, :provider
  end
end
