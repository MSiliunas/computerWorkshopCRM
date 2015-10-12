require_relative 'discount'

# Order
class Order
  STATUS_NEW = 0
  STATUS_INPROGRESS = 1
  STATUS_FINISHED = 2
  STATUS_COMPLETED = 3

  attr_accessor :client, :employee, :computer, :tasks, :discount
  attr_reader :status

  def initialize(client, computer, employee, tasks, discount)
    @status = Order::STATUS_NEW
    @client = client
    @computer = computer
    @employee = employee
    @tasks = tasks
    @discount = discount ? discount : nil
  end

  def total_price
    total_price = 0.0
    tasks.each { |x| total_price += x.price }
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

  def estimated_due_date
    estimated_due_date = Date.today
    estimated_hours = 0.0

    @tasks.each { |x| estimated_hours += x.duration }
    estimated_due_date + (estimated_hours / 8).round
  end

  def status=(new_status)
    @status = new_status if new_status == STATUS_NEW ||
                            new_status == STATUS_INPROGRESS ||
                            new_status == STATUS_FINISHED ||
                            new_status == STATUS_COMPLETED
  end
end
