class DirectionsService
  def self.directions(from, to)
    response = get_json('route', from, to)
    parsed = JSON.parse(response.body, symbolize_names: true)[:route]
  end

  private

  def self.get_json(uri, from, to)
    conn.get(uri) do |req|
      req.params[:from] = from
      req.params[:to] = to
      req.params[:outFormat] = 'json'
      req.params[:routeType] = 'fastest'
      req.params[:ambiguities] = 'ignore'
    end
  end

  def self.conn
    Faraday.new(ENV['DIRECTIONS_SERVICE_URL']) do |f|
      f.params[:key] = ENV['MAPQUEST_CONSUMER_KEY']
    end
  end
end
