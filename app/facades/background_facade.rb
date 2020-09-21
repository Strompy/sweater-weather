class BackgroundFacade
  def self.background_by_location(location)
    image_data = ImageService.get_image(location[/[^,]+/])
    Image.new(image_data, location)
  end
end
