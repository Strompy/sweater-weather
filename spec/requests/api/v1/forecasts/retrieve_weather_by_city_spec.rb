require 'rails_helper'

RSpec.describe 'Get Weather by City Endpoint' do
  it "can receive a location and return the weather data", :vcr do
    location = 'denver,co'
    get "/api/v1/forecast?location=#{location}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    parsed = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(parsed.keys).to eq([:id, :type, :attributes])
    expect(parsed[:type]).to eq("forecast")

    attributes = parsed[:attributes]
    expect(attributes[:location]).to eq(location)

    date_time = attributes[:date_time_info]
    expect(date_time.keys).to eq([:timezone, :offset])
    expect(date_time[:timezone]).to_not eq(nil)
    expect(date_time[:offset]).to_not eq(nil)

    current = attributes[:current]
    expect(current.keys).to eq(
      [
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
      ]
    )
    expect(current.values).to_not include (nil)

    hourly = attributes[:hourly]
    expect(hourly.size).to eq(8)
    hourly.each do |hour|
      expect(hour.keys).to eq([:date_time, :temp, :description])
      expect(hour.values).to_not include(nil)
    end

    daily = attributes[:daily]
    expect(daily.size).to eq(5)
    daily.each do |day|
      expect(day.keys).to eq(
        [
          :date_time,
          :high_temp,
          :low_temp,
          :total_precipitation,
          :description
          ]
        )
        expect(day.values).to_not include(nil)
    end
  end
end

# Request:
#
# GET /api/v1/forecast?location=denver,co
# Content-Type: application/json
# Accept: application/json
#
