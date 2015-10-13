require 'spec_helper'
require 'date'

describe 'Order' do
  before :all do
    @tasks = []
    @tasks.push(Task.new('Reinstall OS', '', 25.00, 4))
    @tasks.push(Task.new('Backup data', '', 15.00, 2))
    @client = Client.new(
      'Marijus',
      'Siliunas',
      '0037064187787',
      'marijus.siliunas@mif.stud.vu.lt',
      ''
    )
    @computer = Computer.new('ASDF123', {}, @client)
    @employee = Employee.new('John', 'Doe', '003706123456', 'email@here.com')
    @order = Order.new(@client, @computer, @employee, @tasks, nil)
    @discount = Discount.new(Discount::TYPE_VALUE, 3)
    @discount_percent = Discount.new(Discount::TYPE_PERCENT, 50)
  end

  it 'returns status' do
    expect(@order.status).to eq Order::STATUS_NEW
  end

  it 'changes status' do
    @order.status = Order::STATUS_INPROGRESS

    expect(@order.status).to eq Order::STATUS_INPROGRESS
  end

  it 'ignores if given status is invalid' do
    @order.status = 999

    expect(@order.status).to eq Order::STATUS_INPROGRESS
  end

  it 'estimates due date' do
    estimated_due_date = Date.today
    estimated_hours = 0.0

    @tasks.each { |x| estimated_hours += x.duration }
    estimated_due_date += (estimated_hours / 8).round

    expect(@order.estimated_due_date).to eq estimated_due_date
  end

  it 'assigns customer' do
    expect(@order.client.firstname).to eq @client.firstname
    expect(@order.client.lastname).to eq @client.lastname
  end

  it 'assigns computer' do
    expect(@order.computer.serial).to eq @computer.serial
  end

  it 'assigns tasks' do
    expect(@order.tasks & @tasks).to eq @tasks
  end

  it 'assigns employee' do
    expect(@order.employee.firstname).to eq @employee.firstname
    expect(@order.employee.lastname).to eq @employee.lastname
  end

  it 'assigns discount' do
    @order.discount = @discount

    expect(@order.discount.type).to eq @discount.type
    expect(@order.discount.value).to eq @discount.value
  end

  it 'calculates total price of tasks' do
    total_price = 0
    @tasks.each { |x| total_price += x.price }

    expect(@order.total_price).to eq total_price
  end

  it 'calculates total price of order with value discount' do
    expect(@order.grand_total_price).to eq 37.0
  end

  it 'calculates total price of order with percent discount' do
    @order.discount = @discount_percent

    expect(@order.grand_total_price).to eq 20.0
  end
end
