require 'rails_helper'

describe 'Client' do
  fixtures :clients
  let(:client) { clients(:first) }

  it 'has string expression' do
    expect(client.to_s).to eq 'First Client 4173674871 first@clie.nt'
  end
end
