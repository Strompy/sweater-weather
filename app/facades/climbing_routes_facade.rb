class ClimbingRoutesFacade
  def self.route_info(location)
    require "pry"; binding.pry
    geocode = GeocodeService.search(location)
    forecast_data = ForecastService.forecast_by_coordinates(geocode)
    foreForecast.new(forecast_data, location)
    RoutesService.nearby_routes(geocode)
    # forecast_info needed => summary, temperature
    # DirectionsService.directions(location?)
  end

end
