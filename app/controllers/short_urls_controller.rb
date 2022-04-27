class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  #Get All
  def index
    @short_url = ShortUrl.limit(1000).order('click_count desc')
    render(json: @short_url)
  end
  #Post
  def create

    @short_url = ShortUrl.new(short_url_params)

    if @short_url.save
      render json: @short_url, status: :created, location: @short_url
    else
      render json: @short_url.errors, status: :unprocessable_entity
    end

  end
  #Get id
  def show
    @short_url = ShortUrl.find_by(title: params[:id])
    if @short_url #Check if found
      @short_url.increment!(:click_count) #Update count
      url = @short_url.full_url
      @short_url.touch(:updated_at) #Update time
      redirect_to url
    else #Show msg error
      render json: "Error: No URL found"
    end
    
  end

  private
  def short_url_params
    params.require(:short_url).permit(:full_url, :title)
  end

end
