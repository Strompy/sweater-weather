class GeocodeService
  def self.search(location)
    response = get_json(location)
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:results][0][:locations][0][:latLng]
  end

  private

  def self.get_json(location)
    conn.get('address') do |req|
      req.params['location']= location
    end
  end

  def self.conn
    Faraday.new(ENV['GEOCODE_SERVICE_URL']) do |f|
      f.params[:key] = ENV['MAPQUEST_CONSUMER_KEY']
    end
  end
end
