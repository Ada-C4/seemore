class CreateHandlesAndUsers < ActiveRecord::Migration
  def change
    create_table :handles_users, id: false do |t|
      t.belongs_to :handle, index: true
      t.belongs_to :user, index: true
    end
  end
end
