class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy,
                                  :subscribe, :unsubscribe]
  before_action :authenticate_user!

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = current_user.feeds.all
    # @entries = @feed.feed_entries.order("published desc").limit(10)
    @entries = FeedEntry.all.order("published desc").limit(10)
                 .where(feed_id: @feeds.ids)
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @entries = @feed.feed_entries.order("published desc").limit(10)
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)

    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def subscribe
    if current_user.feeds << @feed
      flash[:notice] = "Subscribed to #{@feed.title}!"
    else
      flash[:error] = "Couldn't susbcribe to feed"
      render 'show'
    end

    redirect_to @feed
  end

  def unsubscribe
    if current_user.feeds.delete @feed
      flash[:notice] = "Unsubscribed #{@feed.title}!"
    else
      flash[:error] = "Couldn't unsusbcribe to feed"
    end

    redirect_to @feed
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feed_params
      params.require(:feed).permit(:title, :url, :feed_url, :description)
    end
end
