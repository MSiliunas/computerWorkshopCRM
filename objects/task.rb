require_relative '../helpers/active_record'

# Task described with its duration, price, title and description
class Task < ActiveRecord
  attr_reader :duration, :price, :title, :description
  attr_accessor :order_id
  relation_one :Order, 'order_id', :order

  def initialize(title, description, price, duration)
    super()
    @title = title
    @description = description
    @price = price
    @duration = duration
  end

  def to_s
    title
  end

  def save

  end
end
