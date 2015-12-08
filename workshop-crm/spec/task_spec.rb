require 'rails_helper'

describe 'Task' do
  fixtures :tasks
  let(:task) { tasks(:one) }

  it 'has string expression' do
    expect(task.to_s).to eq 'Reinstall OS'
  end
end
