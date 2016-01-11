# compare MA5 & MA20

require 'stock_quote'

code = '000883.SZ'

histories = StockQuote::Stock.history(code, '2015-10-01', '2016-01-11')

sum5, sum20 = 0, 0

histories[0..4].each {|h| sum5 += h.adj_close }
histories[0..19].each {|h| sum20 += h.adj_close}

ma5 = sum5 / 5
ma20 = sum20 / 20

p "MA5: #{ma5} MA20: #{ma20}"
if ma5 < ma20
  p "NO!!"
end

