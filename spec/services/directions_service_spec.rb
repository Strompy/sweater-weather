require 'rails_helper'

RSpec.describe 'ForecastService' do
  it 'searchs by locations and returns trip time', :vcr do
    origin = 'Denver,CO'
    destination = 'Pueblo,CO'
    results = DirectionsService.trip_time(origin, destination)

    expect(results.size).to eq 2
    expect(results[:time_in_seconds]).to_not be_nil
    expect(results[:formatted_time]).to_not be_nil
  end
end
