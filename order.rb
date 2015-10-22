require_relative 'discount'

# Order
class Order
  STATUS_NEW = 0
  STATUS_INPROGRESS = 1
  STATUS_FINISHED = 2
  STATUS_COMPLETED = 3

  attr_writer :discount
  attr_reader :status, :created_at, :employee, :computer, :tasks, :discount

  def initialize(computer, employee, tasks, discount)
    @status = Order::STATUS_NEW
    @computer = computer
    @employee = employee
    @tasks = tasks
    @discount = discount ? discount : nil
    @created_at = Date.today
  end

  def total_price
    total_price = 0.0
    tasks.each { |task| total_price += task.price }
    total_price
  end

  def grand_total_price
    grand_total = total_price
    if @discount
      case @discount.type
      when Discount::TYPE_PERCENT
        grand_total *= 1.0 - @discount.value / 100.0
      when Discount::TYPE_VALUE
        grand_total -= @discount.value
      end
    end

    grand_total
  end

  def tasks_total_duration
    total_hours = 0.0
    @tasks.each { |task| total_hours += task.duration }
    total_hours
  end

  def estimated_due_date
    return_date = @created_at

    work_days = (tasks_total_duration / 8).round

    work_days.times do
      return_date += 1

      return_date.saturday? ? return_date += 3 : return_date
      return_date.sunday? ? return_date += 2 : return_date
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
