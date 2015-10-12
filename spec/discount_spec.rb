require 'spec_helper'

describe 'Discount' do
  discount = Discount.new(Discount::TYPE_PERCENT, 50)

  it 'returns type' do
    expect(discount.type).to eq Discount::TYPE_PERCENT
  end

  it 'returns value' do
    expect(discount.value).to eq 50
  end

  it 'if type not valid throws exception' do
    expect { Discount.new('asdf', -10) }.to raise_error('Invalid discount type')
  end

  it 'if value not valid throws exception' do
    expect { Discount.new(Discount::TYPE_VALUE, -1) }.to raise_error(
      'Invalid discount value'
    )
  end
end
