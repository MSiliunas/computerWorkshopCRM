# Client's order details
class OrderDetail < ActiveRecord::Base
  STATUS_NEW = 0
  STATUS_INPROGRESS = 1
  STATUS_FINISHED = 2
  STATUS_COMPLETED = 3

  belongs_to :order, inverse_of: :order_detail
  has_many :tasks_to_order_details
  has_many :tasks, through: :tasks_to_order_details
  belongs_to :discount
  attr_readonly :status
  belongs_to :employee
  belongs_to :computer
  validates_presence_of :order
  validates_presence_of :employee
  validates_presence_of :computer

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
