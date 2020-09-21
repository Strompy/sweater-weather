class ClimbingRoutesFacade
  def self.route_info(location)
    geocode = GeocodeService.search(location)
    forecast_data = ForecastService.forecast_by_coordinates(geocode)
    forecast = Forecast.new(forecast_data, location)
    routes_data = RoutesService.nearby_routes(geocode)
    routes = create_routes(routes_data, geocode)
    ClimbingRoute.new(location, forecast, routes)
  end

  private

  def self.create_routes(routes, starting_coordinates)
    from = starting_coordinates[:lat].to_s + "," + starting_coordinates[:lng].to_s
    routes.map do |route|
      to = route[:latitude].to_s + "," + route[:longitude].to_s
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

end
