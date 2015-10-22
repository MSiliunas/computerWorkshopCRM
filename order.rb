require_relative 'discount'

# Client's order
class Order
  STATUS_NEW = 0
  STATUS_INPROGRESS = 1
  STATUS_FINISHED = 2
  STATUS_COMPLETED = 3

  attr_reader :status, :created_at, :employee, :computer, :tasks, :discount

  def initialize(computer, employee, tasks, discount)
    @status = Order::STATUS_NEW
    @computer = computer
    @employee = employee
    @tasks = tasks
    self.discount = discount
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
    @discount.price_with_discount(total_price)
  end

  def tasks_total_duration
    total_hours = 0.0
    @tasks.each { |task| total_hours += task.duration }
    total_hours
  end

  def tasks_total_duration_workdays
    (tasks_total_duration / 8).round
  end

  def add_if_weekend(date)
    date += date.saturday? ? 3 : 0
    date.sunday? ? date + 2 : date
  end

  def estimated_due_date
    return_date = @created_at

    tasks_total_duration_workdays.times do
      return_date += 1
      return_date = add_if_weekend(return_date)
    end

    return_date
  end

  def status=(new_status)
    @status = new_status if new_status == STATUS_NEW ||
                            new_status == STATUS_INPROGRESS ||
                            new_status == STATUS_FINISHED ||
                            new_status == STATUS_COMPLETED
  end
end
