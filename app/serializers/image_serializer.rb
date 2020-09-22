class ImageSerializer
  include FastJsonapi::ObjectSerializer
  set_type :image
  attributes :location, :image_url, :credit
end
