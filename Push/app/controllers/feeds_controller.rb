class FeedsController < ApplicationController

  before_filter :set_resources
  #before_action :set_feed, only: [:show, :edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
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
    @feed = @app.feeds.new(feed_params)
    begin
      require 'rss'
      items = RSS::Parser.parse(open(@feed.url).read, false).items
      if @feed.save
        flash[:success] = "Le flux a bien été crée"
      else
        flash[:alert] = "Impossible de créer le flux"
      end
    rescue
     flash[:alert] = "Ce flux RSS ne semble pas valide"
    end
          render json: items
    #redirect_to @app
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

  private

    def set_resources
      @app = App.find(params[:app_id])
      authorize! :destroy, @app
      @feed = Feed.find(params[:id]) if params[:id]
    end

    def feed_params
      params.require(:feed).permit(:url, :name)
    end
end
