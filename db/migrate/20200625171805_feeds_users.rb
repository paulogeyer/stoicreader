class FeedsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds_users, id: false do |t|
      t.integer :user_id
      t.integer :feed_id
    end
  end
end
