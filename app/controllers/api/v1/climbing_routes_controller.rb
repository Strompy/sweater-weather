class Api::V1::ClimbingRoutesController < ApplicationController
  def index
    climbing_route = ClimbingRoutesFacade.route_info(params[:location])
    render json: ClimbingRouteSerializer.new(climbing_route).serialized_json
  end
end
