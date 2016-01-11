class AddCreatedDatestoModels < ActiveRecord::Migration
  def change
    change_table :tweets do |t|
      add_column :tweets, :twitter_created_at, :datetime
    end
    change_table :videos do |t|
      add_column :videos, :vimeo_created_at, :datetime
      add_column :videos, :embed, :string
    end
  end
end
