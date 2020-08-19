require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should have_secure_password }

  describe 'password_update' do
    context 'password is null' do
      it 'should be invalid and returns error message' do
        user = create(:user)

        user.update(old_password: '', password: 'novasenha')

        expect(user.errors.messages[:old_password].first).to eq('A senha é nula.')
      end
    end
    context 'old password is incorrect' do
    end
    context 'password was updated' do
    end
  end
end
