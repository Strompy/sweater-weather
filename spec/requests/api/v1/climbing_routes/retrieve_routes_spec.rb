require 'rails_helper'
# requirements
# Your API will return:
# current forecast for the start location
# name of the route
# type of each route
# rating of each route
# location of each route
# estimated travel time to each route

RSpec.describe "Climbing Routes Location endpoint" do
  it 'Get forecast for a location and nearby climbing routes with the distance to each trail', :vcr do
    location = 'erwin,tn'
    get "/api/v1/climbing_routes?location=#{location}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')
    parsed = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(parsed[:type]).to eq('climbing route')

    attributes = parsed[:attributes]
    expect(attributes[:location]).to eq(location)
    expect(attributes[:forecast].keys).to eq([:location, :temperature])
    expect(attributes[:forecast].values).to_not include(nil)
    routes = attributes[:routes]
    routes.each do |route|
      expect(route.keys).to eq([:name, :type, :rating, :location, :distance_to_route])
      expect(route.values).to_not include(nil)
      expect(route[location].class).to eq(Array)
      expect(route[location]).to_not be_empty
    end
  end
end
# {
#   "data": {
#     "id": "null",
#     "type": "climbing route",
#     "attributes": {
#       "location": "erwin,tn",
#       "forecast": {
#         "summary": "Raining cats and dogs",
#         "temperature": "65"
#       },
#       "routes": [
#         {
#           "name": "Dopey Duck",
#           "type": "Trad",
#           "rating": "5.9",
#           "location": [
#             "North Carolina",
#             "2. Northern Mountains Region",
#             "Linville Gorge",
#             "Shortoff Mountain"
#           ]
#           "distance_to_route": "76.876"
#         },
#         {
#           "name": "Straight and Narrow",
#           "type": "Trad"
#           "rating": "5.10a"
#           "location": [
#             "North Carolina",
#             "2. Northern Mountains Region",
#             "Linville Gorge",
#             "Shortoff Mountain"
#           ]
#           "distance_to_route": "76.876"
#         },
#         {...}
#       ]
#     }
#   }
# }
