module Api
  module V1
    class MaxDailyProfitController < ApplicationController
      def show
        date = Date.parse(params[:date])
        max_profit = calculate_max_profit(date)

        render json: {max_profit: max_profit}
      end

      private

      def calculate_max_profit(date)
        prices = PotatoPrice
          .where(time: date.beginning_of_day..date.end_of_day)
          .order(:time)
          .pluck(:value)

        return 0 if prices.empty?

        max_profit = 0
        min_price = prices.first

        prices.each do |price|
          if price < min_price
            min_price = price
          else
            current_profit = (price - min_price) * 100
            max_profit = [max_profit, current_profit].max
          end
        end

        max_profit
      end
    end
  end
end
