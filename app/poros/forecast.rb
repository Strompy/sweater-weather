class Forecast
  attr_reader :id, :date_time_info, :location, :current, :hourly, :daily

  def initialize(forecast, location)
    @id = nil
    @location = location
    @current = set_current(forecast[:current], forecast[:daily][0][:temp])
    @hourly = []
    @daily = []
    set_hourly(forecast[:hourly])
    set_daily(forecast[:daily])
    @date_time_info = {
      timezone: forecast[:timezone],
      offset: forecast[:timezone_offset]
    }
  end

  private

  def set_current(current, today)
    {
      date_time: current[:dt],
      temp: current[:temp],
      description: current[:weather][0][:description],
      high: today[:max],
      low: today[:min],
      sunrise: current[:sunrise],
      sunset: current[:sunset],
      feels_like: current[:feels_like],
      humidity: current[:humidity],
      visibility_in_miles: (current[:visibility].to_f / 5280).round(2),
      uv_index: current[:uvi]
    }
  end

  def set_hourly(hourly)
    8.times do |i|
      @hourly << parse_hourly(hourly[i])
    end
  end

  def parse_hourly(hourly)
    {
      date_time: hourly[:dt],
      temp: hourly[:temp],
      description: hourly[:weather][0][:description]
    }
  end

  def set_daily(daily)
    5.times do |i|
      @daily << parse_daily(daily[i])
    end
  end

  def parse_daily(daily)
    {
      date_time: daily[:dt],
      high_temp: daily[:temp][:max],
      low_temp: daily[:temp][:min],
      total_precipitation: daily[:rain].to_i + daily[:snow].to_i,
      description: daily[:weather][0][:description]
    }
  end
end
