class AddAttributesForMark < ActiveRecord::Migration
  def change
    add_column :marks, :bio, :string
    add_column :marks, :location, :string
    add_column :marks, :link, :string
  end
end
