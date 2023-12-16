class GetWeatherForecast
  include HTTParty
  prepend SimpleCommand

  base_uri "api.openweathermap.org"

  def initialize(latitude:, longitude:)
    @latitude = latitude
    @longitude = longitude
  end

  def call
    self.class.get("/data/2.5/onecall", options)
  end

  private

  attr_reader :latitude, :longitude

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
