require 'rails_helper'

RSpec.describe ClimbingRoute, :vcr do
  before :each do
    @location = 'erwin,tn'
    geocode = { lat: 39.738453, lng: -104.984853}
    forecast_data = ForecastService.forecast_by_coordinates(geocode)
    @forecast = Forecast.new(forecast_data, @location)
    @routes = [
      {:name=>"Crescent", :type=>"Trad, Ice, Snow, Alpine", :rating=>"WI3- Mod. Snow", :location=>["North Carolina", "Northern Mountains Region", "Black Mountain Range Alpine"], :distance_to_route=>61.615},
      {:name=>"Tiny Roof Crack", :type=>"Boulder", :rating=>"V4+", :location=>["Tennessee", "Blue Hole Falls", "Highball Area", "Shaky Knees Boulder"], :distance_to_route=>34.795},
      {:name=>"La Cascada", :type=>"Boulder", :rating=>"V5", :location=>["Tennessee", "Blue Hole Falls", "Lower Blue Hole", "Levitation Boulder"], :distance_to_route=>34.289},
      {:name=>"Left Wishbone", :type=>"Trad, Ice, Alpine", :rating=>"WI3-", :location=>["North Carolina", "Northern Mountains Region", "Black Mountain Range Alpine"], :distance_to_route=>61.615},
      {:name=>"High Bo Diddle", :type=>"TR, Boulder", :rating=>"5.10a V0", :location=>["North Carolina", "Northern Mountains Region", "Bailey Mountain"], :distance_to_route=>36.105},
      {:name=>"Left Wishbone (Rock Scramble)", :type=>"Trad, Alpine", :rating=>"Easy 5th", :location=>["North Carolina", "Northern Mountains Region", "Black Mountain Range Alpine"], :distance_to_route=>61.615},
      {:name=>"Browns Creek Falls", :type=>"Trad, Ice, Alpine", :rating=>"WI4", :location=>["North Carolina", "Northern Mountains Region", "Black Mountain Range Alpine"], :distance_to_route=>61.615},
      {:name=>"Foot work", :type=>"TR", :rating=>"5.9", :location=>["Tennessee", "Blue Hole Falls", "Highball Area", "Back Crag"], :distance_to_route=>35.933},
      {:name=>"Royal Air", :type=>"Trad, Boulder, Ice, Snow, Alpine", :rating=>"V-easy WI4-5 Mod. Snow R", :location=>["North Carolina", "Northern Mountains Region", "Black Mountain Range Alpine"], :distance_to_route=>61.615},
      {:name=>"Sloth Grip Roll", :type=>"Boulder", :rating=>"V3", :location=>["Tennessee", "Tweetsie Trail - Railroad Cuts", "Rail cut #3 - Tweetsie Trail"], :distance_to_route=>14.597}
   ]
   @climbing_route = ClimbingRoute.new(@location, @forecast, @routes)
  end
  it "is created with attributes" do
    expect(@climbing_route).to be_instance_of(ClimbingRoute)
    expect(@climbing_route.id).to eq(nil)
    expect(@climbing_route.location).to eq(@location)
    expect(@climbing_route.forecast).to eq(@forecast)
    expect(@climbing_route.routes).to eq(@routes)
  end
end
