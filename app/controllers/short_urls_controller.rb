class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  #Get All
  def index
    @short_url = ShortUrl.limit(100).order('click_count desc')
    render(json: @short_url)
  end

  #Post
  def create
    #Generate short code
    short_code = ShortUrl.short_code
    #Insert new ShortURL
    @short_url = ShortUrl.new(short_url_params(short_code))
    if @short_url.save
      puts @short_url.id
      UpdateTitleJob.perform_later(@short_url.id)    #Agregar título con JOB
      render json: @short_url, status: :created, location: @short_url
    else
      render json: @short_url.errors, status: :unprocessable_entity
    end

  end
  #Get id
  def show
    @short_url = ShortUrl.find_by(short_code: params[:id])
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
  def short_url_params(code)
    params.require(:short_url).permit(:full_url).merge(short_code: code)
  end

end
