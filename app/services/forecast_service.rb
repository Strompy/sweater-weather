class ForecastService
  def self.forecast_by_coordinates(coordinates)
    response = get_json(coordinates[:lat], coordinates[:lng])
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.future_forecast(coordinates, hours)
    response = get_json(coordinates[:lat], coordinates[:lng])
    parsed = JSON.parse(response.body, symbolize_names: true)
    {
      temp: parsed[:hourly][hours][:temp],
      description: parsed[:hourly][hours][:weather][0][:description]
    }
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
  end
end
