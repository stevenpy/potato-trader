class DailyProfitCalculator
  MAX_TONNES = 100

  def initialize(date)
    @date = date
  end

  def call
    prices = fetch_prices
    raise ApiErrors::NoDataAvailableError if prices.empty?

    calculate_max_profit(prices)
  end

  private

  def fetch_prices
    PotatoPrice
      .for_date(@date)
      .pluck(:value)
  end

  def calculate_max_profit(prices)
    max_profit = 0
    min_price = prices.first

    prices.each do |price|
      if price < min_price
        min_price = price
      else
        current_profit = (price - min_price) * MAX_TONNES
        max_profit = [max_profit, current_profit].max
      end
    end

    max_profit
  end
end
