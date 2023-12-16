class GetPlaces
  include HTTParty
  prepend SimpleCommand

  base_uri "search.reservamos.mx"

  def initialize(city_name:)
    @city_name = city_name
  end

  def call
    self.class.get("/api/v2/places", options)
  end

  private

  attr_reader :city_name

  def options
    { query: { q: city_name } }
  end
end
