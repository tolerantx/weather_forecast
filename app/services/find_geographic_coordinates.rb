class FindGeographicCoordinates
  prepend SimpleCommand

  def initialize(city_name:)
    @city_name = city_name
  end

  def call
    city_name
  end

  private

  attr_reader :city_name
end
