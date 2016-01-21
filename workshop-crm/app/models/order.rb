# Client's order
class Order < ActiveRecord::Base
  belongs_to :client
  has_one :order_detail, inverse_of: :order
  accepts_nested_attributes_for :order_detail
  validates_associated :order_detail

  def total_price
    total_price = 0.0
    order_detail.tasks.each { |task| total_price += task.price.to_f }
    total_price
  end

  def grand_total_price
    discount = order_detail.discount
    if discount.presence
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
    return_date = order_detail.created_at

    tasks_total_duration_workdays.times do
      return_date += 1.days
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
      computer: order_detail.computer.to_s,
      employee: order_detail.employee.to_s,
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
