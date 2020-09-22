class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.forecast_by_location(params[:location])
    render json: ForecastSerializer.new(forecast).serialized_json
  end
end
