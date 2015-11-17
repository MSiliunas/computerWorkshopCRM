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
    puts 'add_client - create new client'
    puts 'add_computer - add new computer to client'
    puts 'exit - close application'
  end

  def run
    puts 'Hi!'
    print_main_menu

    until @close_me do
      command_input
    end

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
      when 'clients' then print_all(Client)
      when 'exit' then @close_me = true
      else help
    end
  end

  def get_order(id)
    puts Order.get(id)
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
