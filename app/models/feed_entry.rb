class FeedEntry < ApplicationRecord
  belongs_to :feed
  validates :entry_id, uniqueness: true
  validates :feed, presence: true
end
