require 'spec_helper'
require 'date'

describe 'Order' do
  let(:client) do
    Client.new(
      'Marijus',
      'Siliunas',
      '0037061234567',
      'mail@localhost'
    )
  end
  let(:task1) { Task.new('Reinstall OS', 25.00, 4) }
  let(:task2) { Task.new('Backup data', 15.00, 2) }
  let(:computer) { Computer.new('ASDF123', {}, client) }
  let(:employee) do
    Employee.new('John', 'Doe', '003706123456', 'email@here.com')
  end
  let(:order) { Order.new(computer, employee, [task1, task2], nil) }
  let(:order2) { Order.new(computer, employee, [task1, task2], nil) }
  let(:order3) { Order.new(computer, employee, [task1, task2], nil) }

  before :each do
    Order.reset
    Task.reset
  end

  context 'when status changes' do
    it do
      order.details.status = Order::STATUS_INPROGRESS
      expect(order.details.status).to eq Order::STATUS_INPROGRESS
    end

    it 'ignores invalid status' do
      order.details.status = 999
      expect(order.details.status).to eq Order::STATUS_NEW
    end
  end

  context 'estimates order due date' do
    it 'taken on monday' do
      order.instance_variable_set('@created_at', Date.new(2015, 10, 19))
      expect(order.estimated_due_date).to eq Date.new(2015, 10, 20)
    end

    it 'taken on friday' do
      order.instance_variable_set('@created_at', Date.new(2015, 10, 16))
      expect(order.estimated_due_date).to eq Date.new(2015, 10, 20)
    end

    it 'taken on saturday' do
      order.instance_variable_set('@created_at', Date.new(2015, 10, 17))
      expect(order.estimated_due_date).to eq Date.new(2015, 10, 20)
    end

    it do
      order.instance_variable_set('@created_at', Date.new(2015, 10, 16))
      expect(order.estimated_due_date).not_to be_weekend
    end
  end

  it 'calculates total price of tasks' do
    expect(order.total_price).to eq 40.00
  end

  context 'when discount is added' do
    let(:discount)         { Discount.new(Discount::TYPE_VALUE, 3) }
    let(:discount_percent) { Discount.new(Discount::TYPE_PERCENT, 50) }

    it 'assigns discount' do
      order.details.discount = discount
      expect(order.details.discount.type).to eq discount.type
      expect(order.details.discount.value).to eq discount.value
    end

    it 'calculates total price of order with value discount' do
      order.details.discount = discount
      expect(order.grand_total_price).to eq 37.0
    end

    it 'calculates total price of order with percent discount' do
      order.details.discount = discount_percent
      expect(order.grand_total_price).to eq 20.0
    end

    it 'every 3rd order is free of charge' do
      order
      order2
      expect(order3).to free_of_charge
    end
  end

  it 'has string expression' do
    order.details.instance_variable_set('@created_at', Date.new(2015, 11, 17))
    expect(order.to_s).to eq 'id: 1' \
                             "\nprice: 40.0" \
                             "\ncomputer: 8" \
                             "\nemployee: 3" \
                             "\ntasks: Reinstall OS, Backup data" \
                             "\nstatus: 0" \
                             "\ndiscount: " \
                             "\ncreated_at: 2015-11-17\n"
  end
end
