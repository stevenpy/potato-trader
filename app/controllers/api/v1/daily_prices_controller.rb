module Api
  module V1
    class DailyPricesController < ApplicationController
      def show
        date = Date.parse(params[:date])
        prices = PotatoPrice
          .where(time: date.beginning_of_day..date.end_of_day)
          .order(:time)
          .select(:time, :value)

        render json: prices
      end
    end
  end
end
