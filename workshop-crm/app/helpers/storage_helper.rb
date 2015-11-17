require_relative '../models/client'
require_relative '../models/computer'
require_relative '../models/discount'
require_relative '../models/employee'
require_relative '../models/order'
require_relative '../models/task'

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
