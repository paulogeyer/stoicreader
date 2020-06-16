class CreateFeedEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :feed_entries do |t|
      t.string :title
      t.text :content
      t.datetime :published
      t.datetime :updated
      t.string :entry_id
      t.integer :feed_id
      
      t.timestamps
    end
  end
end
