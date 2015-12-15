# Task described with its duration, price, title
class Task < ActiveRecord::Base
  has_many :order_details, through: :tasks_to_order_details
  validates :title, presence: true
  validates :price, presence: true
  validates :duration, presence: true

  def to_s
    title
  end
end
