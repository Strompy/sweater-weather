class DirectionsService
  def self.trip_time(origin, destination)
    response = get_json('route', origin, destination)
    route = JSON.parse(response.body, symbolize_names: true)[:route]
    { time_in_seconds: route[:time], formatted_time: route[:formattedTime] }
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
