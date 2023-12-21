class WeatherForecastDecorator < SimpleDelegator
  def temperatures
    Array(weather_forecast.data["daily"]).drop(1).map do |row|
      {
        timestamp: row["dt"],
        date:      Time.at(row["dt"]).to_date,
        minimum:   row.dig("temp", "min"),
        maximum:   row.dig("temp", "max")
      }
    end
  end

  def from_records
    {
      average: average
    }
  end

  def average
    records = Array(weather_forecast.data["daily"]).drop(1)
    records.map do |row|
      row.dig("temp", "max")
    end.sum / records.size.to_i
  end

  def weather_forecast
    __getobj__
  end
end
