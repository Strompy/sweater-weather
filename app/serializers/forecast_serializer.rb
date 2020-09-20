class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_type :forecast
  attributes :location, :date_time_info, :current, :hourly, :daily
end
