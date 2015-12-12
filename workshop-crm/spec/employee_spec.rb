require 'rails_helper'

describe Employee do
  fixtures :employees
  let(:employee) { employees(:john) }

  it 'has string expression' do
    expect(employee.to_s).to eq 'John Doe 003706123456 email@here.com'
  end
end
