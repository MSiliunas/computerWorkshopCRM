require 'spec_helper'

describe 'Discount' do
  let(:discount) { Discount.new(Discount::TYPE_PERCENT, 50) }

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
end
