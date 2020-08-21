require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should have_secure_password }

  describe 'password_update' do
    context 'password is null' do
      it 'should be invalid and returns error message when old_password is empty' do
        user = create(:user)

        user.update(old_password: '', password: 'novasenha')

        expect(user.errors.messages[:old_password].first).to eq('A senha é nula.')
      end

      it 'should be invalid and returns error message when old_password is nil' do
        user = create(:user)

        user.update(old_password: nil, password: 'novasenha')

        expect(user.errors.messages[:old_password].first).to eq('A senha é nula.')
      end
    end

    context 'old password is incorrect' do
      it 'should be invalid and returns error message when old_password is nil' do
        user = create(:user)

        user.update(old_password: 'foobar', password: 'novasenha')

        expect(user.errors.messages[:old_password].first).to eq('A senha antiga está incorreta.')
      end
    end

    context 'password was updated' do
      it 'should be invalid and returns error message when old_password is nil' do
        user = create(:user)

        user.update(old_password: 'foo123bar', password: 'novasenha')

        expect(BCrypt::Password.new(user.password_digest)).to eq('novasenha')
      end
    end
  end
end
