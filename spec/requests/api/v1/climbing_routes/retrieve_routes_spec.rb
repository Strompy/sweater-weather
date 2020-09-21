require 'rails_helper'

RSpec.describe "Climbing Routes Location endpoint" do
  it 'Get forecast for a location and nearby climbing routes with the distance to each trail', :vcr do
    location = 'erwin,tn'
    get "/api/v1/climbing_routes?location=#{location}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')
    parsed = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(parsed.keys).to eq([:id, :type, :attributes])
    expect(parsed[:type]).to eq('climbing route')

    attributes = parsed[:attributes]
    expect(attributes.keys).to eq([:location, :forecast, :routes])
    expect(attributes[:location]).to eq(location)
    expect(attributes[:forecast].keys).to eq([:summary, :temperature])
    expect(attributes[:forecast].values).to_not include(nil)
    routes = attributes[:routes]
    routes.each do |route|
      expect(route.keys).to eq([:name, :type, :rating, :location, :distance_to_route])
      expect(route.values).to_not include(nil)
      expect(route[:location].class).to eq(Array)
      expect(route[:location]).to_not be_empty
    end
  end
end
