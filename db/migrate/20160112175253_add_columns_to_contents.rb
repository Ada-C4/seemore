class AddColumnsToContents < ActiveRecord::Migration
  def change
    add_column :contents, :provider, :string
  end
end
