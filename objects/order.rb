require_relative 'discount'
require_relative '../helpers/active_record'
require_relative '../helpers/date_helper'

# Client's order
class Order < ActiveRecord
  STATUS_NEW = 0
  STATUS_INPROGRESS = 1
  STATUS_FINISHED = 2
  STATUS_COMPLETED = 3

  attr_reader :status, :created_at, :discount, :employee_id, :computer_id
  relation_one :Computer, 'computer_id', :computer
  relation_one :Employee, 'employee_id', :employee
  relation_one :Client, 'client_id', :client
  relation_many :Task, 'order', :tasks

  def initialize(computer, employee, tasks, discount)
    super()
    @status = Order::STATUS_NEW
    @computer_id = computer.id
    @client_id = computer.client.id
    @employee_id = employee.id
    tasks.each do |task|
      task.order_id = id
    end
    # Every third order is free
    discount = Discount.new(Discount::TYPE_PERCENT, 100) if self.client.orders.size % 3 == 0
    @discount = discount
    @created_at = Date.today
  end

  def discount=(discount)
    @discount = discount ? discount : nil
  end

  def total_price
    total_price = 0.0
    tasks.each { |task| total_price += task.price.to_f }
    total_price
  end

  def grand_total_price
    discount ? discount.price_with_discount(total_price) : total_price
  end

  def tasks_total_duration
    total_hours = 0.0
    tasks.each { |task| total_hours += task.duration }
    total_hours
  end

  def tasks_total_duration_workdays
    (tasks_total_duration / 8).round
  end

  def estimated_due_date
    return_date = @created_at

    tasks_total_duration_workdays.times do
      return_date += 1
      return_date = DateHelper.add_if_weekend(return_date)
    end

    return_date
  end

  def status=(new_status)
    current = @status
    @status = new_status
    @status = current if @status != STATUS_NEW &&
                         @status != STATUS_INPROGRESS &&
                         @status != STATUS_FINISHED &&
                         @status != STATUS_COMPLETED
  end

  def task_list_string
    tasks.each(&:to_s).join(', ')
  end

  def instance_hash
    {
      id: id.to_s,
      status: status.to_s,
      price: grand_total_price.to_s,
      computer: computer_id.to_s,
      employee: employee_id.to_s,
      discount: discount.to_s,
      tasks: task_list_string,
      created_at: created_at.to_s
    }
  end

  def to_s
    str = ''
    instance_hash.each do |param, value|
      str += "#{param}: #{value}\n"
    end
    str
  end
end
