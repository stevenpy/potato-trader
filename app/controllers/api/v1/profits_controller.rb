module Api
  module V1
    class ProfitsController < ApplicationController
      def max_potential_profit
        date = parse_and_validate_date
        max_profit = calculate_max_profit(date, PotatoPrice)

        render json: {max_profit: max_profit}
      end

      private

      def calculate_max_profit(date, price_model)
        DailyProfitCalculator.new(date, price_model).call
      end
    end
  end
end
