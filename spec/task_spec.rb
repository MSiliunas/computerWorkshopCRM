require 'spec_helper'

describe 'Task' do
  let(:task) { Task.new('Reinstall OS', '', 15.0, 2) }

  it 'has string expression' do
    expect(task.to_s).to eq 'Reinstall OS'
  end
end
