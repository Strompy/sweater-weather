require 'rails_helper'

RSpec.describe 'ImageService' do
  it 'searchs by location and returns image data', :vcr do
    location = ('Denver')
    results = ImageService.get_image(location)

    expect(results).to be_instance_of(Hash)

    expect(results[:largeImageURL]).to_not be_nil
    expect(results[:user]).to_not be_nil
  end
end
