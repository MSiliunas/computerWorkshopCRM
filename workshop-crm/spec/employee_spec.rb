require 'rails_helper'

describe Employee do
  let(:employee) { Employee.new('Ponas', 'Ponaitis', '1', 'e@e.lt') }

  it 'has string expression' do
    expect(employee.to_s).to eq 'Ponas Ponaitis 1 e@e.lt'
  end
end
