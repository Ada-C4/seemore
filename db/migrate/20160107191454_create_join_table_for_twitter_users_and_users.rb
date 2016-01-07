class CreateJoinTableForTwitterUsersAndUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users_users, id: false do |t|
      t.belongs_to :twitter_user, index: true
      t.belongs_to :user, index: true
    end
  end
end
