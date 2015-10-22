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
      'marijus.siliunas@mif.stud.vu.lt'
    )
    @computer = Computer.new('ASDF123', {}, @client)
    @employee = Employee.new('John', 'Doe', '003706123456', 'email@here.com')
  end

  before :each do
    @order = Order.new(@computer, @employee, @tasks, nil)
  end

  context 'when status changes' do
    it do
      @order.status = Order::STATUS_INPROGRESS
      expect(@order.status).to eq Order::STATUS_INPROGRESS
    end

    it 'ignores invalid status' do
      @order.status = 999
      expect(@order.status).to eq Order::STATUS_NEW
    end
  end

  context 'estimates order due date' do
    it 'taken on monday' do
      @order.instance_variable_set('@created_at', Date.new(2015, 10, 19))
      expect(@order.estimated_due_date).to eq Date.new(2015, 10, 20)
    end

    it 'taken on friday' do
      @order.instance_variable_set('@created_at', Date.new(2015, 10, 16))
      expect(@order.estimated_due_date).to eq Date.new(2015, 10, 20)
    end

    it 'taken on saturday' do
      @order.instance_variable_set('@created_at', Date.new(2015, 10, 17))
      expect(@order.estimated_due_date).to eq Date.new(2015, 10, 20)
    end
  end

  it 'calculates total price of tasks' do
    total_price = 0
    @tasks.each { |x| total_price += x.price }
    expect(@order.total_price).to eq total_price
  end

  context 'when discount is added' do
    let(:discount)         { Discount.new(Discount::TYPE_VALUE, 3) }
    let(:discount_percent) { Discount.new(Discount::TYPE_PERCENT, 50) }

    it 'assigns discount' do
      @order.discount = discount
      expect(@order.discount.type).to eq discount.type
      expect(@order.discount.value).to eq discount.value
    end

    it 'calculates total price of order with value discount' do
      @order.discount = discount
      expect(@order.grand_total_price).to eq 37.0
    end

    it 'calculates total price of order with percent discount' do
      @order.discount = discount_percent
      expect(@order.grand_total_price).to eq 20.0
    end
  end
end
