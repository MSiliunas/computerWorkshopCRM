# Task described with its duration, price, title and description
class Task
  attr_reader :duration, :price, :title, :description

  def initialize(title, description, price, duration)
    @title = title
    @description = description
    @price = price
    @duration = duration
  end
end
