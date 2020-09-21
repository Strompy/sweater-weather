class ClimbingRoute
  attr_reader :id, :location, :forecast, :routes

  def initialize(location, forecast, routes)
    @id = nil
    @location = location
    @forecast = {
      summary: forecast.current[:description],
      temperature: forecast.current[:temp]
    }
    @routes = routes
  end
end
