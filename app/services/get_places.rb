class GetPlaces
  include HTTParty
  prepend SimpleCommand

  base_uri "search.reservamos.mx"

  attr_reader :city_name, :query

  def initialize(city_name:, query: :q)
    @city_name = city_name
    @query = query
  end

  def call
    return [] unless city_name.present?

    data_filtered
  end

  private

  def data
    @data ||= self.class.get("/api/v2/places", options)
  end

  def options
    { query: { query.to_sym => city_name } }
  end

  def data_filtered
    data.parsed_response.select do |place|
      place["result_type"] == "city"
    end
  end
end
