require  'rails_helper'

RSpec.describe RoadTrip, type: :model do
  it 'can instantiate with attributes' do
    origin = 'Denver, CO'
    destination = 'Pueblo,CO'
    travel_time = {:time_in_seconds=>6237, :formatted_time=>"01:43:57"}
    arrival_forecast = {:temp=>85.39, :description=>"clear sky"}
    road_trip = RoadTrip.new(origin, destination, travel_time, arrival_forecast)

    expect(road_trip).to be_instance_of RoadTrip
    expect(road_trip.origin).to eq origin
    expect(road_trip.destination).to eq destination
    expect(road_trip.travel_time).to eq "01:43"
    expect(road_trip.arrival_forecast).to eq arrival_forecast
    expect(road_trip.id).to eq nil
  end
end
