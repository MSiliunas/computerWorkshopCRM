# Order discount
class Discount
  TYPE_PERCENT = 'percent'
  TYPE_VALUE = 'value'

  attr_reader :value, :type

  def initialize(type, value)
    self.type = type
    self.value = value
  end

  def price_with_discount(price)
    grand_total = price

    case @type
    when Discount::TYPE_PERCENT
      grand_total *= 1.0 - @value / 100.0
    when Discount::TYPE_VALUE
      grand_total -= @value
    end

    grand_total
  end

  def type=(type)
    if type == Discount::TYPE_PERCENT || type == Discount::TYPE_VALUE
      @type = type
    else
      fail Exception, 'Invalid discount type'
    end
  end

  def value=(value)
    if  (type == Discount::TYPE_PERCENT && value.between?(0, 100)) ||
        (type == Discount::TYPE_VALUE && value > 0)
      @value = value
    else
      fail Exception, 'Invalid discount value'
    end
  end
end
