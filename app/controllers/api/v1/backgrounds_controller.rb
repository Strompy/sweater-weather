class Api::V1::BackgroundsController < ApplicationController
  def index
    background = BackgroundFacade.background_by_location(params[:location])
    render json: ImageSerializer.new(background).serialized_json
  end
end
