class Api::V1::ForecastController < ApplicationController
  def index
    forecast_object = ForecastFacade.forecast_by_location(params[:location])
    require "pry"; binding.pry
    render json: ForecastSerializer.render(forecast)
  end
end
