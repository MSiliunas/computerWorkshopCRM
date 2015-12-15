require 'rails_helper'

describe 'Discount' do
  fixtures :discounts
  let(:discount_percent) { discounts(:percent) }
  let(:discount_value) { discounts(:value) }

  context 'when data not valid' do
    it do
      expect do
        Discount.new(discount_type: 'asdf', value: -10)
      end.to raise_error('Invalid discount type')
    end

    it do
      expect do
        Discount.new(discount_type: Discount::TYPE_VALUE, value: -1)
      end.to raise_error('Invalid discount value')
    end
  end

  it 'changes discount value' do
    discount_value.stubs(:value).returns(1)
    expect(discount_value.price_with_discount(10)). to eq 9
  end

  it 'sets new value' do
    old = discount_value.value
    discount_value.value = 22
    expect(discount_value.value).not_to eq old
  end

  context 'when discount type is percent' do
    it do
      expect(discount_percent.price_with_discount(10)). to eq 5
    end
  end

  context 'when discount type is value' do
    it do
      expect(discount_value.price_with_discount(10)). to eq 7
    end
  end
end
