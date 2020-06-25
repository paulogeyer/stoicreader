class CreateHabtmRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :liked_entries, id: false do |t|
      t.integer :user_id
      t.integer :feed_entry_id
    end

    create_table :disliked_entries, id: false do |t|
      t.integer :user_id
      t.integer :feed_entry_id
    end

    create_table :read_entries, id: false do |t|
      t.integer :user_id
      t.integer :feed_entry_id
    end
  end
end
