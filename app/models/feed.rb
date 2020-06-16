class Feed < ApplicationRecord
  before_create :get_feed_data
  after_create 
  validates :url, presence: true
  validates :url, uniqueness: true
  has_many :feed_entries

  def get_feed_entries
    data = Net::HTTP.get(URI(self.url))
    feed = Feedjira.parse data

    feed.entries.each do |entry|
      f = FeedEntry.find_by_entry_id entry.entry_id
      if f
        # TODO: check if the entry was updated
      else
        nf = FeedEntry.new(title: entry.title,
                           content: entry.content,
                           published: entry.published,
                           updated: entry.updated,
                           entry_id: entry.entry_id,
                           feed: f)
        nf.save
      end
    end
  end

  def get_feed_data
    data = Net::HTTP.get(URI(self.url))
    feed = Feedjira.parse data
    self.title = feed.title
    self.url = feed.url
    self.feed_url = feed.feed_url
    self.description = feed.description
  end
end
