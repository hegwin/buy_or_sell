class HStock::GSL
  class << self
    # y = a + bx
    # d = y[i] - a - bx[i]
    # min(d ^ 2)
    def get_linear_fitting_slope(x=[],y=[])
      raise StandardError if x.count != y.count

      n = x.count.to_f

      x_avg = x.inject {|sum, i| sum + i } / n
      y_avg = y.inject {|sum, i| sum + i } / n
      xy_avg = x.map.with_index {|e, i| e * y[i]}.inject {|sum, i| sum + i} / n
      x_sqr_avg = x.inject {|sqr_sum, i| sqr_sum + i**2 } / n

      slope = (x_avg * y_avg - xy_avg) / ( x_avg ** 2 - x_sqr_avg)
    end
  end
end
