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
  relation_one :Computer, 'computer_id', :order
  relation_one :Employee, 'employee_id', :employee
  relation_many :Task, 'order', :tasks

  def initialize(computer, employee, tasks, discount)
    super()

    discount = Discount.new(Discount::TYPE_PERCENT, 100) if @id % 3 == 0

    @status = Order::STATUS_NEW
    @computer_id = computer.id
    @employee_id = employee.id
    tasks.each { |task| task.order_id = id }
    @discount = discount
    @created_at = Date.today
  end

  def discount=(discount)
    @discount = discount ? discount : nil
  end

  def total_price
    total_price = 0.0
    tasks.each { |task| total_price += task.price }
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

  def to_s
    'id: ' + id.to_s +
      "\nstatus: " + status.to_s +
      "\nprice: " + grand_total_price.to_s +
      "\ncomputer: " + computer_id.to_s +
      "\nemployee: " + employee_id.to_s +
      "\ndiscount: " + discount.to_s +
      "\ntasks: " + task_list_string +
      "\ncreated at: " + created_at.to_s
  end
end
