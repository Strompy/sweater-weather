require 'rails_helper'

RSpec.describe 'Road Trip endpoint' do
  before :each do
    @user = create(:user)
  end
  it 'accepts post with key, start and end. returns travel and forecast' do
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

    expect(parsed[:type]).to eq('road trip')
    # expect(parsed[:id]).to eq(@user.id.to_s)(nil)
    attributes = parsed[:attributes]
    expect(attributes.keys).to eq([:origin, :destination, :travel_time, :arrival_forecast])
    expect(attributes[:origin]).to eq(origin)
    expect(attributes[:destination]).to eq(destination)
    expect(attributes[:travel_time]).to_not be_nil
    expect(attributes[:arrival_forecast][:temp]).to_not be_nil
    expect(attributes[:arrival_forecast][:description]).to_not be_nil

  end
  it 'denies a request with no api key' do
    # expect(response.status).to eq(401)

  end
  it 'denies a request with bad api key' do
    # expect(response.status).to eq(401)

  end
end
