class CityWeatherForecast
  prepend SimpleCommand

  attr_reader :error, :city_name

  def initialize(city_name:)
    @city_name = city_name
  end

  def call
    return [] unless city_name.present?

    weather_forecast
  rescue => e
    Rails.logger.info(e.message)
    @error = { error: "Something went wrong:" }
  end

  private

  def cities
    @cities ||= GetPlaces.call(city_name: city_name).result[0..4]
  end

  def weather_forecast
    @weather_forecast ||= cities.map do |city|
      weather_forecast = WeatherForecastByCoords.call(latitude: city["lat"], longitude: city["long"])
      weather_forecast_decorator = WeatherForecastDecorator.new(weather_forecast)

      {
        city_slug: city["slug"]
      }.merge(weather_forecast_decorator.from_records)
    end
  end
end
