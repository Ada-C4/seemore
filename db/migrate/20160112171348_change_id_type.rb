class ChangeIdType < ActiveRecord::Migration
  def change
    change_column :contents, :content_id, :string
  end
end
