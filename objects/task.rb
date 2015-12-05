require_relative '../helpers/active_record'
require_relative 'order'

# Task described with its duration, price, title and description
class Task < ActiveRecord
  attr_reader :duration, :price, :title, :order_details_id
  relation_one :OrderDetails, 'order_details_id', :order_details

  def initialize(title, price, duration)
    super()
    @title = title
    @price = price
    @duration = duration
  end

  def order_details_id=(id)
    @order_details_id = id if OrderDetails.get(id)
  end

  def to_s
    title
  end

  def save
  end
end
