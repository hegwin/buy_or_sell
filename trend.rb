# encoding: utf-8
# compare MA5 & MA20

require 'stock_quote'

code = '000883.SZ'

histories = StockQuote::Stock.history(code, '2015-10-01', '2016-01-11')
prices = histories.map(&:adj_close)

ma5 = prices[0..4].inject {|sum, price| sum + price } / 5
ma20 = prices[0..19].inject {|sum, price| sum + price } / 20

pma5 = prices[1..5].inject {|sum, price| sum + price } / 5
pma20 = prices[1..20].inject {|sum, price| sum + price } / 20

p "MA5: #{ma5} MA20: #{ma20}"
if ma5 > ma20
  p "YES!!"
  if pma5 < pma20
    p "买入"
  else
    p "继续持仓"
  end
elsif ma5 < ma20
  p "NO!!"
  if pma5 < pma20
    p "保持空仓"
  else
    p "卖出"
  end
end

