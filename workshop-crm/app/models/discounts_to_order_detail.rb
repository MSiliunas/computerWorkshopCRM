class DiscountsToOrderDetail < ActiveRecord::Base
  belongs_to :discount
  belongs_to :order_detail
end
