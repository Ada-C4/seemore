class CreateHandles < ActiveRecord::Migration
  def change
    create_table :handles do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
