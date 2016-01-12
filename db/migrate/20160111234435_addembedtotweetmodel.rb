class Addembedtotweetmodel < ActiveRecord::Migration
  def change
    change_table :tweets do |t|
      add_column :tweets, :embed, :string
    end
  end
end
