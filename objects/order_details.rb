require_relative '../helpers/active_record'

# Client's order details
class OrderDetails < ActiveRecord
  STATUS_NEW = 0
  STATUS_INPROGRESS = 1
  STATUS_FINISHED = 2
  STATUS_COMPLETED = 3

  attr_reader :status, :discount, :created_at
  relation_many :Task, 'order_details', :tasks

  def initialize(tasks)
    super()
    @status = OrderDetails::STATUS_NEW
    tasks.each { |task| task.order_details_id = id }
    @created_at = Date.today
  end

  def discount=(discount)
    @discount = discount unless @discount
  end

  def status=(new_status)
    current = @status
    @status = new_status
    @status = current if @status != STATUS_NEW &&
                         @status != STATUS_INPROGRESS &&
                         @status != STATUS_FINISHED &&
                         @status != STATUS_COMPLETED
  end

  def to_s
    {
      status: status.to_s,
      discount: discount.to_s,
      created_at: created_at.to_s
    }
  end
end
