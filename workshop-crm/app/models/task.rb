class Task < ActiveRecord::Base
  def initialize(title, price, duration)
    self.title = title
    self.price = price
    self.duration = duration
  end

  def to_s
    title
  end
end
