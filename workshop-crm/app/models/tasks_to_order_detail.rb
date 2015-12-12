# Many-to-many tasks: to order details
class TasksToOrderDetail < ActiveRecord::Base
  belongs_to :order_detail
  belongs_to :task
end
