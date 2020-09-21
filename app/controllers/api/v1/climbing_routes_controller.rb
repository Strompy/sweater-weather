class Api::V1::ClimbingRoutesController < ApplicationController
  def index
    location = params[:location]
    ClimbingRoutesFacade.route_info(location)
    require "pry"; binding.pry
  end
end
