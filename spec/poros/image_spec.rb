require 'rails_helper'

RSpec.describe Image, :vcr do
  before :each do
    @location = 'denver,co'
    @image_data = ImageService.get_image(@location[/[^,]+/])
    @image = Image.new(@image_data, @location)
  end
  it 'is created with attributes' do
    expect(@image).to be_instance_of(Image)
    expect(@image.location).to eq(@location)
    expect(@image.image_url).to include('.com')
    expect(@image.credit.keys).to eq([:source, :author, :logo])
    expect(@image.credit[:source]).to eq('pixabay.com')
    expect(@image.credit[:author]).to_not be_nil
    expect(@image.credit[:logo]).to eq('https://pixabay.com/static/img/logo_square.png')
  end
end
