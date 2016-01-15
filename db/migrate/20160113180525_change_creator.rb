class ChangeCreator < ActiveRecord::Migration
  def change
    change_column :creators, :p_id, :string
  end
end
