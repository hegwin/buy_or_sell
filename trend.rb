# compare MA5 & MA20

require 'stock_quote'
require 'i18n'

I18n.load_path = Dir['./i18n/*.yml']
I18n.available_locales = [:en , :cn]
#I18n.locale = :cn

def trend(ma5, ma20, pma5, pma20)
  if ma5 > ma20
    if pma5 < pma20
      :bid
    else
      :possession
    end
  else
    if pma5 < pma20
      :bear_position
    else
      :ask
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

  results[symbol] = I18n.t(trend(ma5, ma20, pma5, pma20))

end

p results

__END__
a = []
0.upto(prices.size-20).each do |n|
  ma5 = prices[n..(n+4)].inject {|sum, price| sum + price } / 5
  ma20 = prices[n..(n+19)].inject {|sum, price| sum + price } / 20

  pma5 = prices[(n+1)..(n+5)].inject {|sum, price| sum + price } / 5
  pma20 = prices[(n+1)..(n+20)].inject {|sum, price| sum + price } / 20

  t = trend(ma5, ma20, pma5, pma20)
  if t.length <3
    a <<[ t, prices[n]]
  end


end

a.reverse!

