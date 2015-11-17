require 'spec_helper'

describe Auth do
  context 'when creating a new user' do
    let(:user) do
      User.new
    end

    it 'hashes the password' do
      user.password = 'test'
      expect(user.password).to eq \
        '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08'
    end
  end
end
