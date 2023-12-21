class CityWeatherForecastFrom
  prepend SimpleCommand

  attr_reader :city_name

  def initialize(city_name:)
    @city_name = city_name
  end

  def call
    weather_forecast.sort_by do |row|
      row[:average]
    end.last
  end

  def cities
    @cities ||= GetPlaces.call(city_name: city_name, query: :from).result[0..4]
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
