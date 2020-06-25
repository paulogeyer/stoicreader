class FeedEntriesController < ApplicationController
  def index
  end

  def show
    @feed_entry = FeedEntry.find(params[:id])
    @last_entries = @feed_entry.feed.feed_entries.all
                      .order('published desc').limit(5)
  end
end
