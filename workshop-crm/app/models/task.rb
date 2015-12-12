# Task described with its duration, price, title
class Task < ActiveRecord::Base
  has_many :order_details, through: :tasks_to_order_details

  def to_s
    title
  end
end
