require 'spec_helper'

describe 'Discount' do
  let(:discount_percent) { Discount.new(Discount::TYPE_PERCENT, 50) }
  let(:discount_value) { Discount.new(Discount::TYPE_VALUE, 3) }

  context 'when data not valid' do
    it do
      expect do
        Discount.new('asdf', -10)
      end.to raise_error('Invalid discount type')
    end

    it do
      expect do
        Discount.new(Discount::TYPE_VALUE, -1)
      end.to raise_error('Invalid discount value')
    end
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
