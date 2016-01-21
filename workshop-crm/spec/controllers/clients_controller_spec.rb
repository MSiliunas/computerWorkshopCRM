require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  fixtures :clients

  describe 'GET index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
