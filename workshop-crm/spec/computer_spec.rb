require 'rails_helper'

describe 'Computer' do
  fixtures :computers

  it 'has string expression' do
    computer = computers(:one)
    expect(computer.to_s).to eq 'ASDF123'
  end

  it 'detects if computer already in system' do
    computer = computers(:one)
    computer1 = Computer.new
    computer1.stubs(:serial).returns('ASDF123')

    expect(computer).to same_computer(computer1)
  end
end
