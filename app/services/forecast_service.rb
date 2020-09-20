class ForecastService
  def self.forecast_by_coordinates(coordinates)
    response = get_json(coordinates[:lat], coordinates[:lng])
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.get_json(latitude, longitude)
    conn.get do |req|
      req.params[:lat] = latitude
      req.params[:lon] = longitude
      req.params[:exclude] = 'minutely'
      req.params[:units] = 'imperial'
    end
  end

  def self.conn
    Faraday.new(ENV['WEATHER_SERVICE_URL']) do |f|
      f.params[:appid] = ENV['OPENWEATHER_API_KEY']
    end
    # https://api.openweathermap.org/data/2.5/onecall?lat=39.738453&lon=-104.984853&exclude=minutely&appid=46df3f7eac8eb9a5b2ba2e9523107b1b
  end
end
