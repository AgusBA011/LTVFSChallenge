class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    #Get register
    @short_url = ShortUrl.find_by(id: short_url_id)
    #Load URL and parse it with Nokogiri to get title in HTML DOM
    open(short_url.full_url) do |f|
      f.read
      doc = Nokogiri::HTML(f)
      @short_url.update(title: doc.at_css('title').text)
    end
  end
end
