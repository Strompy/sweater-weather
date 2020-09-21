class RoutesService
  def self.nearby_routes(coordinates)
    response = get_json('get-routes-for-lat-lon', coordinates)
    parsed = JSON.parse(response.body, symbolize_names: true)[:routes]
  end

  private

  def self.get_json(uri, query)
    conn.get(uri) do |req|
      req.params[:lat] = query[:lat]
      req.params[:lon] = query[:lng]
      req.params[:maxResults] = 10
    end
  end

  def self.conn
    Faraday.new(ENV['ROUTES_SERVICE_URL']) do |f|
      f.params[:key] = ENV['MOUNTAIN_PROJECT_KEY']
    end
  end
end
