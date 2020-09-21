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


# {
#   "type": "image",
#   "id": null,
#   "image": {
#     "location": "denver,co",
#     "image_url": "https://pixabay.com/get/54e6d4444f50a814f1dc8460962930761c38d6ed534c704c7c2878dd954dc451_640.jpg",
#     "credit": {
#       "source": "pixabay.com",
#       "author": "quinntheislander",
#       "logo": "https://pixabay.com/static/img/logo_square.png"
#     }
#   }
# }
  end
end
