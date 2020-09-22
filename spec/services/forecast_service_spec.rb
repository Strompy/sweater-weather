require 'rails_helper'

RSpec.describe 'ForecastService' do
  it 'searchs by coordinates and returns weather data', :vcr do
    coordinates = { lat: 39.738453, lng: -104.984853 }
    results = ForecastService.forecast_by_coordinates(coordinates)

    expect(results).to be_instance_of(Hash)
    expect(results.keys).to include(:timezone, :timezone_offset)
    expect(results.values).to_not include(nil)

    expect(results[:current].keys).to include(:dt, :temp, :weather, :sunrise, :sunset, :feels_like, :humidity, :visibility, :uvi)
    expect(results[:current].values).to_not include(nil)
    expect(results[:current][:weather][0][:description]).to_not be nil

    expect(results[:hourly].size).to eq(48)
    expect(results[:hourly][0].keys).to include(:dt, :temp)
    expect(results[:hourly][0][:weather][0][:description]).to_not be nil

    expect(results[:daily].size).to eq(8)
    expect(results[:daily][0][:dt]).to_not be nil
    expect(results[:daily][0][:temp][:max]).to_not be nil
    expect(results[:daily][0][:temp][:min]).to_not be nil
    expect(results[:daily][0][:weather][0][:description]).to_not be nil

  end
end
