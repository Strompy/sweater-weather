require 'rails_helper'

RSpec.describe 'Road Trip endpoint' do
  before :each do
    @user = create(:user)
  end
  it 'accepts post with key, start and end. returns travel and forecast', :vcr do
    origin = 'Denver,CO'
    destination = 'Pueblo,co'

    headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    user_params = {
      "origin": origin,
      "destination": destination,
      "api_key": @user.api_key
    }

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json')
    parsed = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(parsed[:type]).to eq('road_trip')
    
    attributes = parsed[:attributes]
    expect(attributes.keys).to eq([:origin, :destination, :travel_time, :arrival_forecast])
    expect(attributes[:origin]).to eq(origin)
    expect(attributes[:destination]).to eq(destination)
    expect(attributes[:travel_time]).to_not be_nil
    expect(attributes[:arrival_forecast].size).to eq(2)
    expect(attributes[:arrival_forecast][:temp].class).to eq(Float)
    expect(attributes[:arrival_forecast][:description]).to_not be_nil

  end
  it 'denies a request with no api key' do
    origin = 'Denver,CO'
    destination = 'Pueblo,co'

    headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    user_params = {
      "origin": origin,
      "destination": destination,
    }

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json')
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed.size).to eq(1)
    expect(parsed[:errors]).to eq('API key required')
  end
  it 'denies a request with bad api key' do
    origin = 'Denver,CO'
    destination = 'Pueblo,co'

    headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    user_params = {
      "origin": origin,
      "destination": destination,
      "api_key": 'dudewheresmykey?'
    }

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json')
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed.size).to eq(1)
    expect(parsed[:errors]).to eq('Invalid key')
  end
end
