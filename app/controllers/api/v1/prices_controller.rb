module Api
  module V1
    class PricesController < ApplicationController
      def daily_prices
        date = Date.parse(params[:date])
        prices = PotatoPrice
          .where(time: date.beginning_of_day..date.end_of_day)
          .order(:time)
          .pluck(:time, :value)
          .map { |time, value| {time: time, value: value} }

        render json: prices
      end
    end
  end
end
