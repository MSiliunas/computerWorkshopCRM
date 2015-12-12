require 'rails_helper'
require 'date'

describe 'Order' do
  fixtures :all
  let(:client) { clients(:first) }
  let(:task1) { tasks(:one) }
  let(:task2) { tasks(:two) }
  let(:computer) { computers(:one) }
  let(:employee) { employees(:john) }
  let(:order) { orders(:first) }
  let(:order2) { orders(:second) }
  let(:order3) { orders(:third) }

  context 'when status changes' do
    it do
      order.order_detail.status = OrderDetail::STATUS_INPROGRESS
      expect(order.order_detail.status).to eq OrderDetail::STATUS_INPROGRESS
    end

    it 'ignores invalid status' do
      order.order_detail.status = 999
      expect(order.order_detail.status).to eq OrderDetail::STATUS_INPROGRESS
    end
  end

  context 'estimates order due date' do
    it 'taken on monday' do
      order.order_detail.created_at = Date.new(2015, 10, 19)
      expect(order.estimated_due_date).to eq Date.new(2015, 10, 20)
    end

    it 'taken on friday' do
      order.order_detail.created_at = Date.new(2015, 10, 16)
      expect(order.estimated_due_date).to eq Date.new(2015, 10, 20)
    end

    it 'taken on saturday' do
      order.order_detail.created_at = Date.new(2015, 10, 17)
      expect(order.estimated_due_date).to eq Date.new(2015, 10, 20)
    end

    it do
      order.order_detail.created_at = Date.new(2015, 10, 16)
      expect(order.estimated_due_date).not_to be_weekend
    end
  end

  it 'calculates total price of tasks' do
    expect(order.total_price).to eq 40.00
  end

  context 'when discount is added' do
    let(:discount)         { discounts(:value) }
    let(:discount_percent) { discounts(:percent) }

    it 'assigns discount' do
      order.order_detail.discount = discount
      type = discount.discount_type
      expect(order.order_detail.discount.discount_type).to eq type
      expect(order.order_detail.discount.value).to eq discount.value
    end

    it 'calculates total price of order with value discount' do
      order.order_detail.discount = discount
      expect(order.grand_total_price).to eq 37.0
    end

    it 'calculates total price of order with percent discount' do
      order.order_detail.discount = discount_percent
      expect(order.grand_total_price).to eq 20.0
    end

    it 'every 3rd order is free of charge' do
      order3.client.orders.stubs(:size).returns(6)
      expect(order3).to free_of_charge
    end
  end

  it 'has string expression' do
    order.order_detail.stubs(:created_at).returns(DateTime.new(2015, 11, 17, 14))
    expect(order.to_s).to eq 'id: 1'\
                             "\nprice: 40.0"\
                             "\ncomputer: ASDF123"\
                             "\nemployee: John Doe 003706123456 email@here.com"\
                             "\ntasks: Reinstall OS, Backup data" \
                             "\nstatus: 1"\
                             "\ndiscount: "\
                             "\ncreated_at: 2015-11-17T14:00:00+00:00\n"
  end
end
