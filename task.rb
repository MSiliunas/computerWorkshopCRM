# Task
class Task
  attr_accessor :duration, :price, :title, :description

  def initialize(title, description, price, duration)
    @title = title
    @description = description
    @price = price
    @duration = duration
  end
end
