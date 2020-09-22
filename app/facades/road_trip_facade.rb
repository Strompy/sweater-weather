class RoadTripFacade
  def self.plan_trip(origin, destination)
    travel_time = DirectionsService.trip_time(origin, destination)
    rounded_hours = ((travel_time[:time_in_seconds].to_f / 60) / 60 ).round
    geocode = GeocodeService.search(destination)
    forecast = ForecastService.future_forecast(geocode, rounded_hours)
    RoadTrip.new(origin, destination, travel_time, forecast)
  end

  private

  # refactor all the service calls
end
