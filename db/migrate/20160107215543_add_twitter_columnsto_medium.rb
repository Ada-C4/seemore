class AddTwitterColumnstoMedium < ActiveRecord::Migration
  def change
    remove_column :media, :url
    add_column :media, :text, :string
    add_column :media, :uri, :string
  end
end
