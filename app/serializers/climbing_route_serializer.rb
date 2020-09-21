class ClimbingRouteSerializer
  include FastJsonapi::ObjectSerializer
  set_type 'climbing route'
  attributes :location, :forecast, :routes
end
