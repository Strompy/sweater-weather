require  'rails_helper'

RSpec.describe Forecast, :vcr do
  before :each do
    @location = 'denver,co'
    geocode = { lat: 39.738453, lng: -104.984853}
    @forecast_data = ForecastService.forecast_by_coordinates(geocode)
    @forecast = Forecast.new(@forecast_data, @location)
  end
  it "is created with attributes" do
    expect(@forecast).to be_instance_of(Forecast)
    expect(@forecast.id).to eq(nil)
    expect(@forecast.location).to eq(@location)
    expect(@forecast.date_time_info.class).to eq(Hash)
    expect(@forecast.current.class).to eq(Hash)
    expect(@forecast.current.keys).to include(
      :date_time,
      :temp,
      :description,
      :high,
      :low,
      :sunrise,
      :sunset,
      :feels_like,
      :humidity,
      :visibility_in_miles,
      :uv_index
    )
    expect(@forecast.current.values).to_not include(nil)

    expect(@forecast.hourly[0].class).to eq(Hash)
    expect(@forecast.hourly[0].keys).to include(
      :date_time,
      :temp,
      :description
    )
    expect(@forecast.hourly[0].values).to_not include(nil)

    expect(@forecast.daily[0].class).to eq(Hash)
    expect(@forecast.daily[0].keys).to include(
      :date_time,
      :high_temp,
      :low_temp,
      :total_precipitation,
      :description
    )
    expect(@forecast.daily[0].values).to_not include(nil)
  end
end
