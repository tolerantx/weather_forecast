class WeatherForecastController < ApplicationController
  before_action :get_service, only: :index

  def index
    status = @service.error.present? ? :unprocessable_entity : :ok
    render json: @service.result, status: status
  end

  def places
    render json: CityWeatherForecastFrom.call(city_name: params[:from]).result, status: :ok
  end

  private

  def get_service
    @service = CityWeatherForecast.call(city_name: params[:city_name])
  end
end
