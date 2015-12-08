# Client's order
class Order < ActiveRecord::Base
  belongs_to :client, inverse_of: :orders
  has_one :order_detail, inverse_of: :order
  has_one :computer
  has_one :employee

  def initialize(computer, employee, tasks, discount, client)
    @order_detail = OrderDetail.new(tasks)
    @computer = computer
    @client = computer
    @employee = employee
    @client = client
    process_discount(discount)
  end

  def process_discount(discount)
    # Every third order is free
    order_detail.discount = if client.orders.size % 3 == 0
                         Discount.new(Discount::TYPE_PERCENT, 100)
                       else
                         discount
                       end
  end

  def total_price
    total_price = 0.0
    order_detail.tasks.each { |task| total_price += task.price.to_f }
    total_price
  end

  def grand_total_price
    discount = order_detail.discount
    if discount
      discount.price_with_discount(total_price)
    else
      total_price
    end
  end

  def tasks_total_duration
    total_hours = 0.0
    order_detail.tasks.each { |task| total_hours += task.duration }
    total_hours
  end

  def tasks_total_duration_workdays
    (tasks_total_duration / 8).round
  end

  def estimated_due_date
    return_date = created_at

    tasks_total_duration_workdays.times do
      return_date += 1
      return_date = DateHelper.add_if_weekend(return_date)
    end

    return_date
  end

  def task_list_string
    order_detail.tasks.each(&:to_s).join(', ')
  end

  def instance_hash
    {
      id: id.to_s,
      price: grand_total_price.to_s,
      computer: computer.to_s,
      employee: employee.to_s,
      tasks: task_list_string
    }.merge(order_detail.to_s)
  end

  def to_s
    str = ''
    instance_hash.each do |param, value|
      str += "#{param}: #{value}\n"
    end
    str
  end
end
