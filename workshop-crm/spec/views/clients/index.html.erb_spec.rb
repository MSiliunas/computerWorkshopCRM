require 'rails_helper'

describe 'clients/index.html.erb' do
  fixtures :clients

  context 'Client list' do
    before :each do
      assign(:clients, clients)
    end

    it 'has title' do
      render
      assert_select 'h3', 'Listing clients'
    end

    it 'has table' do
      render
      assert_select 'table'
    end

    it 'has 1 entry' do
      render
      expect(rendered).to have_tag('tr')
    end
  end
end
