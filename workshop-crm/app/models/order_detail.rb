# Client's order details
class OrderDetail < ActiveRecord::Base
  STATUS_NEW = 0
  STATUS_INPROGRESS = 1
  STATUS_FINISHED = 2
  STATUS_COMPLETED = 3

  belongs_to :order, inverse_of: :order_detail
  has_many :tasks, through: :order_details_to_tasks
  has_one :discount, through: :discounts_to_order_details
  attr_reader :status

  def initialize(tasks)
    @status = OrderDetail::STATUS_NEW
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
