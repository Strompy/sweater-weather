require 'rails_helper'

RSpec.describe 'DirectionsService' do
  it 'can search with coordinates and return distance', :vcr do
    from = "36.147506,-82.413996"
    to = "35.8536,-82.2401"

    results = DirectionsService.directions(from, to)

    expect(results).to be_instance_of(Hash)
    expect(results[:distance]).to_not be_nil
  end
end
