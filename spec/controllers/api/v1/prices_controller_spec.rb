require "rails_helper"

RSpec.describe Api::V1::PricesController, type: :controller do
  describe "GET #daily_prices" do
    let(:date) { "2022-08-22" }

    context "when data exists for the date" do
      before do
        PotatoPrice.create!([
          {time: "2022-08-22T09:00:00.000Z", value: 2},
          {time: "2022-08-22T09:10:02.800Z", value: 9},
          {time: "2022-08-22T09:20:03.800Z", value: 12}
        ])
      end

      it "returns prices for the given date" do
        get :daily_prices, params: {date: date}

        expect(response).to have_http_status(:ok)

        prices = JSON.parse(response.body)
        expect(prices.length).to eq(3)
        expect(prices.first["value"]).to eq("2.0")
        expect(prices.last["value"]).to eq("12.0")
      end
    end

    context "when no data exists for the date" do
      it "returns a not found error" do
        get :daily_prices, params: {date: "2023-01-01"}

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("No data available for this date")
      end
    end

    context "with invalid date format" do
      it "returns a bad request error" do
        get :daily_prices, params: {date: "invalid-date"}

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["error"]).to include("Invalid date format")
      end
    end

    context "with future date" do
      it "returns a bad request error" do
        future_date = (Date.today + 1.day).to_s
        get :daily_prices, params: {date: future_date}

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["error"]).to include("Invalid date format")
      end
    end

    context "when date parameter is missing" do
      it "returns a bad request error" do
        expect {
          get :daily_prices
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end
end
