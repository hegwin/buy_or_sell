# compare MA5 & MA20

require 'stock_quote'

code = '000883.SZ'

histories = StockQuote::Stock.history(code, '2015-10-01', '2016-01-11')
prices = histories.map(&:adj_close)

ma5 = prices[0..4].inject {|sum, price| sum + price } / 5
ma20 = prices[0..19].inject {|sum, price| sum + price } / 20

p "MA5: #{ma5} MA20: #{ma20}"
if ma5 > ma20
  p "YES!!"
elsif ma5 < ma20
  p "NO!!"
end

