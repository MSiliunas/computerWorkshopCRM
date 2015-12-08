class DiscountsToOrderDetail < ActiveRecord::Base
  has_one :discount, index: true, foreign_key: true
  has_one :order_detail, index: true, foreign_key: true
end
