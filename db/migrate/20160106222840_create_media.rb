class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :url
      t.string :type
      t.belongs_to :handle, index: true

      t.timestamps null: false
    end
  end
end
