require 'rails_helper'

RSpec.describe 'Get Weather by City Endpoint' do
  it "can receive a location and return the weather data", :vcr do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    # expect(data)
  end

end

# Request:
#
# GET /api/v1/forecast?location=denver,co
# Content-Type: application/json
# Accept: application/json
#
