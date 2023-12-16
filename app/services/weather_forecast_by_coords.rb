class WeatherForecastByCoords
  include HTTParty
  prepend SimpleCommand

  base_uri "api.openweathermap.org"

  attr_reader :latitude, :longitude

  def initialize(latitude:, longitude:)
    @latitude = latitude
    @longitude = longitude
  end

  def call
    data.parsed_response
  end

  def data
    @data ||= self.class.get("/data/2.5/onecall", options)
  end

  private

  def options
    {
      query: {
        lon:     longitude,
        lat:     latitude,
        appid:   appid,
        exclude: exclude_data,
        units:   units
      }
    }
  end

  def appid
    @appid ||= Rails.application.credentials.open_weather_api_key
  end

  def exclude_data
    "current,minutely,hourly,alerts"
  end

  def units
    "metric"
  end
end
