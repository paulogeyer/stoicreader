class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @subscriptions = current_user.feeds
    @feeds = Feed.all.order("title")
  end

  def create
  end

  def destroy
  end
end
