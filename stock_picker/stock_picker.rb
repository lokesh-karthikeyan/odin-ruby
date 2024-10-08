def stock_picker(prices)
  profit = 0
  buy_on = 0
  sell_on = 0
  prices.each_with_index do |price_to_buy, buy_day|
    prices.each_with_index do |price_to_sell, sell_day|
      next unless sell_day > buy_day && price_to_sell - price_to_buy > (profit)

      profit = price_to_sell - price_to_buy
      buy_on = buy_day
      sell_on = sell_day
    end
  end
  [buy_on, sell_on]
end

stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
