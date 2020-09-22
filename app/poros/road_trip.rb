class RoadTrip
  attr_reader :id, :origin, :destination, :travel_time, :arrival_forecast
  def initialize(origin, destination, travel_time, forecast)
    @id = nil
    @origin = origin
    @destination = destination
    @travel_time = travel_time[:formatted_time][0..-4]
    @arrival_forecast = forecast
  end
end
