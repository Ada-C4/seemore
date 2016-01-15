class AddLastUpdatedToCreators < ActiveRecord::Migration
  def change
    add_column :creators, :last_updated, :datetime
  end
end
