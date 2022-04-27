class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate : validate_full_url 
  def short_code
  end

  def update_title!
  end

  private
  def validate_full_url
    puts "Validating"
    uri = URI.parse(:full_url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

end
