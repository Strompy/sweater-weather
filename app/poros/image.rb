class Image
  attr_reader :id, :location, :image_url, :credit
  def initialize(info, location)
    @id = nil
    @location = location
    @image_url = info[:largeImageURL]
    @credit = {
      source: 'pixabay.com',
      author: info[:user],
      logo: 'https://pixabay.com/static/img/logo_square.png'
    }
  end
end
