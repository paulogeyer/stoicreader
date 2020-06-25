class Feed < ApplicationRecord
  before_create :get_feed_data
  after_create :get_feed_entries
  validates :url, presence: true
  validates :url, uniqueness: true
  has_many :feed_entries
  has_and_belongs_to_many :users

  def self.fetch_new_feed_entries
    Feed.all.each do |feed|
      begin
        feed.get_feed_entries
      rescue SocketError
        next
      end
    end
  end

  def get_feed_entries
    puts "feed_id: #{self.id}"
    puts "url: #{self.url}"

    begin
      data = Net::HTTP.get(URI(self.url))
      feed = Feedjira.parse data
    rescue Feedjira::NoParserAvailable
      data = Net::HTTP.get(URI(self.feed_url))
      feed = Feedjira.parse data
    rescue Errno::ECONNREFUSED
      data = Net::HTTP.get(URI(self.feed_url))
      feed = Feedjira.parse data
    end

    return nil if feed.entries.empty?

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
                           feed_id: self.id)
        nf.save
      end
    end
  end

  def get_feed_data
    data = Net::HTTP.get(URI(self.url))
    feed = Feedjira.parse data
    self.title = feed.title
    self.feed_url = self.url
    self.url = feed.url
    self.description = feed.description
  end
end
