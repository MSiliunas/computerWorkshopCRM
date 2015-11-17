require 'spec_helper'

describe 'Computer' do
  let(:computer) { Computer.new('ASDF123', {}) }
  let(:computer1) { Computer.new('ASDF123', {}) }

  it 'has string expression' do
    expect(computer.to_s).to eq 'ASDF123'
  end

  it 'detects if computer already in system' do
    expect(computer).to same_computer(computer1)
  end
end
