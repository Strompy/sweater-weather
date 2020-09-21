class ImageService
  def self.get_image(keyword)
    response = get_json(keyword)
    parsed = JSON.parse(response.body, symbolize_names: true)
    if parsed[:hits].size < 2
      parsed[:hits][0]
    else
      parsed[:hits][1]
    end
  end

  private

  def self.get_json(search)
    conn.get do |req|
      req.params['q'] = search
    end
  end

  def self.conn
    Faraday.new(ENV['IMAGE_SERVICE_URL']) do |f|
      f.params[:key] = ENV['PIXABAY_API_KEY']
    end
  end
end
