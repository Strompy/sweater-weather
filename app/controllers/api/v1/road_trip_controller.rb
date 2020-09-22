class Api::V1::RoadTripController < ApplicationController
  before_action :current_user

  def create
    origin = trip_params[:origin]
    destination = trip_params[:destination]
    trip = RoadTripFacade.plan_trip(origin, destination)
    render json: RoadTripSerializer.new(trip)
  end

  private

  def trip_params
    params.permit(:origin, :destination)
  end

  def user_params
    params.permit(:api_key)
  end

  def current_user
    if user_params[:api_key].nil?
      render json: { errors: 'API key required' }, status: :unauthorized and return
    end
    user = User.find_by(api_key: user_params[:api_key])
    if user.nil?
      render json: { errors: 'Invalid key' }, status: :unauthorized and return
    else
      user
    end
  end
end
