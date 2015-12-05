require_relative '../helpers/storage_helper'

# :nocov:
# Simple console user interface
class ConsoleUI
  def initialize
    puts 'Loading saved state...'
    StorageHelper.load_state
    @close_me = false
  end

  def print_main_menu
    puts 'employees - print employee list'
    puts 'orders - print all orders'
    puts 'order xx - print order with id "xx"'
    puts 'clients - print all clients'
    puts 'add_order - create new order'
    puts 'add_task - create new task'
    puts 'add_client - create new client'
    puts 'add_computer - add new computer to client'
    puts 'add_employee - create new employee'
    puts 'exit - close application'
  end

  def run
    puts 'Hi!'
    print_main_menu

    command_input until @close_me

    close_app
  end

  def string_input
    gets.chomp
  end

  def integer_input
    gets.to_i
  end

  def command_input
    print '~: '
    command_execute(string_input)
  end

  def help
    print_main_menu
  end

  def command_execute(command)
    args = command.split(' ')
    case args[0]
    when 'employees' then print_all(Employee)
    when 'orders' then print_all(Order)
    when 'order' then get_order(args[1].to_i)
    when 'add_client' then add_client
    when 'add_computer' then add_computer
    when 'add_order' then add_order
    when 'add_task' then add_task
    when 'add_employee' then add_employee
    when 'clients' then print_all(Client)
    when 'exit' then @close_me = true
    else help
    end
  end

  def get_order(id)
    puts Order.get(id)
  end

  def add_employee
    print 'Firstname: '
    firstname = string_input
    print 'Lastname: '
    lastname = string_input
    print 'Phone Number: '
    phone = string_input
    print 'Email: '
    email = string_input
    employee = Employee.new(firstname, lastname, phone, email)
    puts employee.to_s
    print 'OK? [y/N]: '
    case string_input
    when 'y'
      Employee.dump
      puts 'Employee successfully created!'
    else
      employee.delete
      puts 'Employee creation aborted.'
    end
  end

  def add_task
    print 'Title: '
    title = string_input
    print 'Description: '
    description = string_input
    print 'Price: '
    price = string_input
    print 'Duration (hours): '
    duration = string_input
    task = Task.new(title, description, price, duration)
    puts task.to_s
    print 'OK? [y/N]: '
    case string_input
    when 'y'
      Task.dump
      puts 'Task successfully created!'
    else
      client.delete
      puts 'Task creation aborted.'
    end
  end

  def add_order
    puts 'Choose a computer (id)'
    print_all(Computer)
    computer = integer_input
    computer = Computer.find_by(id: computer.to_i)
    puts 'Choose tasks (id) 1,2...'
    print_all(Task)
    tasks = string_input
    tasks = tasks_hash(tasks)
    print_all(Employee)
    employee = integer_input
    employee = Employee.find_by(id: employee.to_i)
    puts computer.inspect
    puts employee.inspect
    puts tasks.inspect
    order = Order.new(computer[0], employee[0], tasks, nil)
    puts order.to_s
    print 'OK? [y/N]: '
    case string_input
    when 'y'
      Order.dump
      puts 'Order successfully created!'
    else
      order.delete
      puts 'Order creation aborted.'
    end
  end

  def tasks_hash(string)
    tasks = []
    task_ids = string.split(',')
    task_ids.each do |taskId|
      tasks << Task.find_by(id: taskId.to_i)[0]
    end
    tasks
  end

  def add_client
    print 'Firstname: '
    firstname = string_input
    print 'Lastname: '
    lastname = string_input
    print 'Phone Number: '
    phone = string_input
    print 'Email: '
    email = string_input
    client = Client.new(firstname, lastname, phone, email)
    puts client.to_s
    print 'OK? [y/N]: '
    case string_input
    when 'y'
      Client.dump
      puts 'Client successfully created!'
    else
      client.delete
      puts 'Client creation aborted.'
    end
  end

  def add_computer
    puts 'Choose a client (id)'
    print_all(Client)
    client_id = integer_input
    print 'Serial Number: '
    serial = string_input
    computer = Computer.new(serial, {})
    computer.client_id = client_id
    print 'OK? [y/N]: '
    case string_input
    when 'y'
      Computer.dump
      puts 'Computer successfully added!'
    else
      computer.delete
      puts 'Computer adding canceled.'
    end
  end

  def print_all(type)
    type.find_by.each do |instance|
      puts '=====' + instance.id.to_s + '======'
      puts instance.to_s
    end
  end

  def close_app
    StorageHelper.save_state
    puts 'State saved.'
    puts 'Goodbye!'
  end
end
# :nocov:
