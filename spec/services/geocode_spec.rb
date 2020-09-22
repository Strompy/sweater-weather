require 'rails_helper'

RSpec.describe 'GeocodeService' do
  it 'searchs by location and returns coordinates', :vcr do
    location = ('Denver,co')
    results = GeocodeService.search(location)
    expect(results).to be_instance_of(Hash)
    expect(results.size).to eq(2)
    expect(results.keys).to eq([:lat, :lng])
    expect(results.values).to_not include(nil)
  end
end
