require 'rails_helper'

describe 'Client' do
  let(:client) { Client.new('Ponas', 'Ponaitis', '1', 'e@e.lt') }

  it 'has string expression' do
    expect(client.to_s).to eq 'Ponas Ponaitis 1 e@e.lt'
  end
end
