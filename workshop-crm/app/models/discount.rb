# Order discount
class Discount < ActiveRecord::Base
  TYPE_PERCENT = 'percent'
  TYPE_VALUE = 'value'

  has_many :orders

  def price_with_discount(price)
    grand_total = price

    case discount_type
    when TYPE_PERCENT
      grand_total *= 1.0 - value / 100.0
    when TYPE_VALUE
      grand_total -= value
    end

    grand_total
  end

  def discount_type=(type)
    if type == TYPE_PERCENT || type == TYPE_VALUE
      super(type)
    else
      fail Exception, 'Invalid discount type'
    end
  end

  def value=(new_value)
    if (discount_type == TYPE_PERCENT && new_value.between?(0, 100)) ||
       (discount_type == TYPE_VALUE && new_value > 0)
      super(new_value)
    else
      fail Exception, 'Invalid discount value'
    end
  end
end
