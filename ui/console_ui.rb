require_relative '../helpers/storage_helper'

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
    when 'exit' then @close_me = true
    else help
    end
  end

  def get_order(id)
    puts Order.get(id)
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
