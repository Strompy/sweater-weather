require 'rails_helper'

RSpec.describe 'GeocodeService' do
  it 'searchs by location and returns coordinates', :vcr do
    location = ('Denver,co')
    results = GeocodeService.search(location)
    expect(results).to be_instance_of(Hash)
    expect(results.size).to eq(2)
    expect(results).to have_key(:lat)
    expect(results).to have_key(:long)
  end
end
