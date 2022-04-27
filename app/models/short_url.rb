class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validates :full_url,
            presence: true,
            format: { with: URI.regexp(%w(http https)), message: :bad_url_format }
  
  validate :validate_full_url 
  def short_code
    
  end

  def update_title!
  end

  private
  def validate_full_url
    unless self.full_url.blank? || self.full_url =~ /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
      self.errors.add(:full_url, "Invalid URL")
    end
  end

end
