require "rails_helper"

describe WeatherForecastController do
  describe "GET #index" do
    it { expect(response).to have_http_status(200) }

    # This test takes a long time because it consumes the external APIs,
    # the goal would be to stub the http request or use VCR
    context "when the city_name parameter is present" do
      before do
        get :index, params: { city_name: "Monterrey" }

      end

      xit "renders a list of cities" do
        expect(JSON.parse(response.body)).not_to be_empty
      end
    end

    context "when the city_name parameter is empty" do
      before do
        get :index
      end

      it "renders an empty array" do
        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context "when the request gets an exception" do
      before do
        allow(GetPlaces).to receive(:call).with(city_name: "foo").and_raise(StandardError.new("error"))

        get :index, params: { city_name: "foo" }
      end

      it "renders an error" do
        json_parsed = JSON.parse(response.body)
        expect(json_parsed["error"]).not_to be_empty
      end
    end
  end
end
