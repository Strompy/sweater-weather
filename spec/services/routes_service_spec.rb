require 'rails_helper'

RSpec.describe 'RoutesService' do
  it 'searched by coordinates and returns 10 routes' do
    coordinates = {:lat=>36.147506, :lng=>-82.413996}
    results = RoutesService.nearby_routes(coordinates)

    expect(results).to be_instance_of(Array)
    expect(results.size).to be <= 10
    expect(results[0]).to be_instance_of(Hash)
    results.each do |result|
      expect(result[:name]).to_not be_nil
      expect(result[:type]).to_not be_nil
      expect(result[:rating]).to_not be_nil
      expect(result[:location]).to_not be_nil
      expect(result[:longitude]).to_not be_nil
      expect(result[:latitude]).to_not be_nil
    end
  end
end
