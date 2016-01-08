class CreateSubscriptionUsersTable < ActiveRecord::Migration
  def change
    create_table :subscriptions_users do |t|
      t.integer :subscription_id
      t.integer :user_id
    end
  end
end
