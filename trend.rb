# encoding: utf-8
# compare MA5 & MA20

require 'stock_quote'

def trend(ma5, ma20, pma5, pma20)
  if ma5 > ma20
    if pma5 < pma20
      "建仓"
    else
      "继续持仓"
    end
  else
    if pma5 < pma20
      "保持空仓"
    else
      "清仓"
    end
  end
end

symbols = File.readlines('./portfolio.txt').map(&:chomp)
results = {}
end_date = ARGV[0] || Date.today.to_s

symbols.each do |symbol|

  histories = StockQuote::Stock.history(symbol, '2015-10-01', end_date)
  prices = histories.map(&:adj_close)

  ma5 = prices[0..4].inject {|sum, price| sum + price } / 5
  ma20 = prices[0..19].inject {|sum, price| sum + price } / 20

  pma5 = prices[1..5].inject {|sum, price| sum + price } / 5
  pma20 = prices[1..20].inject {|sum, price| sum + price } / 20

  results[symbol] = trend(ma5, ma20, pma5, pma20)

end

p results
