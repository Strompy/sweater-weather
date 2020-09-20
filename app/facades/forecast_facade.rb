class ForecastFacade
  def self.forecast_by_location(location)
    require "pry"; binding.pry
    geocode = GeocodeService.search(location)
    forecast_data = ForecastService.forecast_by_coordinates(geocode)
    Forecast.new(forecast_data, location) #location if necessary
  end
end
