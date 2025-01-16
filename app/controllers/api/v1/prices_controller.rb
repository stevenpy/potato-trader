module Api
  module V1
    class PricesController < ApplicationController
      def daily_prices
        date = parse_and_validate_date
        prices = fetch_prices_per_date(date)

        raise ApiErrors::NoDataAvailableError if prices.empty?
        render json: prices
      end

      private

      def fetch_prices_per_date(date)
        PotatoPrice
          .for_date(date)
          .pluck(:time, :value)
          .map { |time, value| {time: time, value: value} }
      end
    end
  end
end
