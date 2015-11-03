require_relative '../objects/client'
require_relative '../objects/computer'
require_relative '../objects/discount'
require_relative '../objects/employee'
require_relative '../objects/order'
require_relative '../objects/task'

# Helps to work with storage
class StorageHelper
  def self.save_state
    Client.dump
    Computer.dump
    # Discount.dump
    Employee.dump
    Order.dump
    Task.dump
  end

  def self.load_state
    Client.load
    Computer.load
    # Discount.load
    Employee.load
    Order.load
    Task.load
  end
end
