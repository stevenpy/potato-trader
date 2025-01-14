module Api
  module V1
    class ProfitsController < ApplicationController
      def max_potential_profit
        date = Date.parse(params[:date])
        max_profit = calculate_max_profit(date)

        render json: {max_profit: max_profit}
      end

      private

      def calculate_max_profit(date)
        DailyProfitCalculator.new(date).call
      end
    end
  end
end
