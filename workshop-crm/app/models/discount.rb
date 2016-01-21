# Order discount
class Discount < ActiveRecord::Base
  DISCOUNT_TYPES = {
    percent: 'percent',
    value: 'value'
  }

  has_many :orders

  def price_with_discount(price)
    grand_total = price

    case discount_type
    when DISCOUNT_TYPES[:percent]
      grand_total *= 1.0 - value / 100.0
    when DISCOUNT_TYPES[:value]
      grand_total -= value
    end

    grand_total
  end

  def discount_type=(type)
    if DISCOUNT_TYPES.value?(type)
      super(type)
    else
      fail Exception, 'Invalid discount type'
    end
  end

  def value=(new_value)
    if (discount_type == DISCOUNT_TYPES[:percent] &&
        new_value.between?(0, 100)) ||
       (discount_type == DISCOUNT_TYPES[:value] && new_value > 0)
      super(new_value)
    else
      fail Exception, 'Invalid discount value'
    end
  end
end
