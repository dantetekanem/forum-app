require "rails_helper"

RSpec.describe User, type: :model do
  let(:valid_user_params) do
    {
      email: 'test@email.com', password: '123change', password_confirmation: '123change',
      name: 'Test User', username: 'test-user'
    }
  end
  let(:invalid_user_params) do
    valid_user_params.dup.tap do |params|
      params[:username] = ''
    end
  end
  let(:user) { User.new(valid_user_params) }
  let(:invalid_user) { User.new(invalid_user_params) }

  describe '#create' do
    it 'can create a valid user' do
      expect(user).to be_valid
      expect { user.save }.to change { User.count }.by(1)
    end

    it 'cannot create a user without a valid param' do
      expect(invalid_user).to_not be_valid
      expect { invalid_user.save }.to change { User.count }.by(0)
    end
  end
end
