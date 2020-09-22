require 'rails_helper'

RSpec.describe "Get background image endpoint" do
  it "returns image and data", :vcr do
    location = 'denver,co'

    get "/api/v1/backgrounds?location=#{location}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')
    parsed = JSON.parse(response.body, symbolize_names: true)[:data]

    # assertions
    expect(parsed[:type]).to eq('image')
    image_info = parsed[:attributes]
    expect(image_info.keys).to eq([:location, :image_url, :credit])
    expect(image_info[:location]).to eq(location)
    expect(image_info[:image_url]).to_not be_nil
    expect(image_info[:credit].keys).to eq([:source, :author, :logo])
    expect(image_info[:credit].values).to_not include(nil)
  end
end
