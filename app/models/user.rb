class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :feeds
  has_and_belongs_to_many :read_entries,
                          join_table: 'read_entries',
                          class_name: 'FeedEntry'
  has_and_belongs_to_many :liked_entries,
                          join_table: 'liked_entries',
                          class_name: 'FeedEntry'
  has_and_belongs_to_many :disliked_entries,
                          join_table: 'disliked_entries',
                          class_name: 'FeedEntry'
end
