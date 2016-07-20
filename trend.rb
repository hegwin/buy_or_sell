# compare MA5 & MA20

require './lib/h_stock'
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

symbols.each do |symbol|
  ma = HStock::MA.get(symbol, limit: 2, types: [5, 20])

  results[symbol] = I18n.t(trend(ma[5].first, ma[20].first, ma[5].first, ma[20].last))

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

