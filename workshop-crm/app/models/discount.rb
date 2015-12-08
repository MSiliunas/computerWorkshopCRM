class Discount < ActiveRecord::Base
  TYPE_PERCENT = 'percent'
  TYPE_VALUE = 'value'

  def initialize(discount_type, value)
    self.discount_type = discount_type
    self.value = value
  end

  def price_with_discount(price)
    grand_total = price

    case discount_type
    when Discount::TYPE_PERCENT
      grand_total *= 1.0 - value / 100.0
    when Discount::TYPE_VALUE
      grand_total -= value
    end

    grand_total
  end

  def discount_type=(type)
    if type == Discount::TYPE_PERCENT || type == Discount::TYPE_VALUE
      @discount_type = type
    else
      fail Exception, 'Invalid discount type'
    end
  end

  def value=(new_value)
    if  (@discount_type == Discount::TYPE_PERCENT && new_value.between?(0, 100)) ||
        (@discount_type == Discount::TYPE_VALUE && new_value > 0)
      @value = new_value
    else
      fail Exception, 'Invalid discount value'
    end
  end
end
