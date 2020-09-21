class ClimbingRoutesFacade
  def self.route_info(location)
    geocode = GeocodeService.search(location)
    forecast = get_forecast(geocode, location)
    routes = create_routes(geocode)
    ClimbingRoute.new(location, forecast, routes)
  end

  private

  def self.get_forecast(geocode, location)
    forecast_data = ForecastService.forecast_by_coordinates(geocode)
    Forecast.new(forecast_data, location)
  end

  def self.create_routes(starting_coordinates)
    routes = RoutesService.nearby_routes(starting_coordinates)
    from = format_coordinates(starting_coordinates)
    routes.map do |route|
      to = format_coordinates(route)
      distance = DirectionsService.directions(from, to)[:distance]
      {
        "name": route[:name],
        "type": route[:type],
        "rating": route[:rating],
        "location": route[:location],
        "distance_to_route": distance
      }
    end
  end

  def self.format_coordinates(coordinates)
    if coordinates[:lat]
      coordinates[:lat].to_s + "," + coordinates[:lng].to_s
    else
      coordinates[:latitude].to_s + "," + coordinates[:longitude].to_s
    end
  end
end
