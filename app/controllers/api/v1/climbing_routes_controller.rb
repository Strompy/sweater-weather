class Api::V1::ClimbingRoutesController < ApplicationController
  def index
    location = params[:location]
    climbing_route = ClimbingRoutesFacade.route_info(location)
    render json: ClimbingRouteSerializer.new(climbing_route).serialized_json
  end
end
