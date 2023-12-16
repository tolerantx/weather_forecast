class CityWeatherForecast
  prepend SimpleCommand

  attr_reader :error, :city_name

  def initialize(city_name:)
    @city_name = city_name
  end

  def call
    weather_forecast
  rescue => e
    Rails.logger.info(e.message)
    @error = { error: "Something went wrong:" }
  end

  private

  def cities
    @cities ||= GetPlaces.call(city_name: city_name).result
  end

  def weather_forecast
    @weather_forecast ||= cities.map do |city|
      weather_forecast = WeatherForecastByCoords.call(latitude: city["lat"], longitude: city["long"])
      weather_forecast_decorator = WeatherForecastDecorator.new(weather_forecast)

      {
        city_slug: city["slug"]
      }.merge(
        temperatures: weather_forecast_decorator.temperatures
      )
    end
  end
end
