class RoutesService
  def self.nearby_routes(coordinates)
    require "pry"; binding.pry
    get_json('get-routes-for-lat-lon', coordinates)
  end

  private

  def self.get_json(uri, query)
    conn.get(uri) do |req|
      req.params[:lat] = query[:lat]
      req.params[:lon] = query[:lng]
    end
  end

  def self.conn
    Faraday.new(ENV['ROUTES_SERVICE_URL']) do |f|
      f.params[:key] = ENV['MOUNTAIN_PROJECT_KEY']
    end
  end
end
