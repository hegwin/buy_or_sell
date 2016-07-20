class HStock::MA
  DEFAULT_TYPES = [5, 10, 20, 30]

  def self.get(symbol, opts={})
    ma_types = DEFAULT_TYPES & opts[:types]
    limit = opts[:limit] || 5

    result = {}
    
    histories = StockQuote::Stock.history(symbol, '2015-10-01', Date.today.to_s)
    prices = histories.map(&:adj_close)

    ma_types.each do |n|
      result[n] = (0..(limit-1)).map do |i|
        (prices[(0+i)..(0+i-1+n)].inject {|sum, price| sum + price } / n).round(4)
      end
    end

    result
  end
end
