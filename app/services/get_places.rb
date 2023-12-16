class GetPlaces
  include HTTParty
  prepend SimpleCommand

  base_uri "search.reservamos.mx"

  attr_reader :city_name

  def initialize(city_name:)
    @city_name = city_name
  end

  def call
    data.parsed_response
  end

  private

  def data
    @data ||= self.class.get("/api/v2/places", options)
  end

  def options
    { query: { q: city_name } }
  end
end
