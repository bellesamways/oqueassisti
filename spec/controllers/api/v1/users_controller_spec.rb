require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe 'GET #index' do
    before do
      5.times do
        create(:user)
      end
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected users attributes' do
      hash_body = JSON.parse(response.body)

      keys = []

      hash_body.each do |h|
        keys << h.keys
      end

      expect(keys.flatten.uniq).to match_array(
        ["_id", "created_at", "email", "name", "password_digest", "updated_at", "username"]
      )
    end
  end

  describe 'GET #show' do
    before do
      user = create(:user)
      get :show, params: { id: user.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected users attributes' do
      hash_body = JSON.parse(response.body)

      expect(hash_body.keys).to match_array(
        ["_id", "created_at", "email", "name", "password_digest", "updated_at", "username"]
      )
    end
  end

  describe 'POST #create' do
    it 'returns http created when all fields it is ok' do
      post :create, params: {
        "user": {
          "name": 'testezinho',
          "email": 'testezinho@teste.com',
          "username": 'testezinho',
          "password": '123teste'
        }
      }

      expect(response).to have_http_status(:created)
      expect(User.first.username).to eq('testezinho')
    end

    it 'returns http unprocessable_entity when email is empty' do
      post :create, params: {
        "user": {
          "name": 'testezinho',
          "email": '',
          "username": 'testezinho',
          "password": '123teste'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns http unprocessable_entity when password is empty' do
      post :create, params: {
        "user": {
          "name": 'testezinho',
          "email": 'testezinho@teste.com',
          "username": 'testezinho',
          "password": ''
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns http unprocessable_entity when username is already taken' do
      post :create, params: {
        "user": {
          "name": 'testezinho',
          "email": 'testezinho@teste.com',
          "username": 'testezinho',
          "password": '123teste'
        }
      }

      expect(response).to have_http_status(:created)

      post :create, params: {
        "user": {
          "name": 'testelegal',
          "email": 'testelegal@teste.com',
          "username": 'testezinho',
          "password": '123teste'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to have_content 'is already taken'
    end
  end

  describe 'PATCH #update' do
    before do
      create(:user,
             name: 'teste legal',
             email: 'testelegal@teste.com',
             username: 'testelegal',
             password: '123teste')
    end

    it 'returns ok when change the username to a valid username' do
      user = User.first

      patch :update, params: { id: user.id, user: {
        username: 'testezinho',
        old_password: '123teste'
      } }

      expect(response).to have_http_status(:ok)

      user.reload
      expect(user.username).to eq('testezinho')
      expect(BCrypt::Password.new(user.password_digest)).to eq('123teste')
    end

    it 'returns not ok when change the username to a invalid username because it is not unique' do
      user = User.first

      create(:user,
             name: 'testezinho',
             email: 'testezinho@teste.com',
             username: 'testezinho',
             password: '123teste')

      patch :update, params: { id: user.id, user: {
        username: 'testezinho',
        old_password: '123teste'
      } }

      expect(response).to have_http_status(:unprocessable_entity)

      user.reload
      expect(user.username).to eq('testelegal')
      expect(BCrypt::Password.new(user.password_digest)).to eq('123teste')
    end

    it 'returns not ok when change the email to a invalid email because it is not unique' do
      user = User.first

      create(:user,
             name: 'testezinho',
             email: 'testezinho@teste.com',
             username: 'testezinho',
             password: '123teste')

      patch :update, params: { id: user.id, user: {
        email: 'testezinho@teste.com',
        old_password: '123teste'
      } }

      expect(response).to have_http_status(:unprocessable_entity)

      user.reload
      expect(user.email).to eq('testelegal@teste.com')
      expect(BCrypt::Password.new(user.password_digest)).to eq('123teste')
    end

    it 'returns ok when change the password correctly' do
      user = User.first

      expect(BCrypt::Password.new(user.password_digest)).to eq('123teste')

      patch :update_password, params: { id: user.id, user: {
        old_password: '123teste',
        password: 'teste123'
      } }

      expect(response).to have_http_status(:ok)

      user.reload

      expect(BCrypt::Password.new(user.password_digest)).to eq('teste123')
    end

    it 'returns not ok when change the password incorrectly with blank old_password' do
      user = User.first

      expect(BCrypt::Password.new(user.password_digest)).to eq('123teste')

      patch :update_password, params: { id: user.id, user: {
        old_password: '',
        password: 'teste123'
      } }

      expect(response).to have_http_status(:unprocessable_entity)

      user.reload

      expect(BCrypt::Password.new(user.password_digest)).to eq('123teste')
    end

    it 'returns not ok when change the password incorrectly with incorrect old_password' do
      user = User.first

      expect(BCrypt::Password.new(user.password_digest)).to eq('123teste')

      patch :update_password, params: { id: user.id, user: {
        old_password: 'teste123',
        password: '123teste'
      } }

      expect(response).to have_http_status(:unprocessable_entity)

      user.reload

      expect(BCrypt::Password.new(user.password_digest)).to eq('123teste')
    end

    it 'returns not ok when change the password incorrectly with blank password' do
      user = User.first

      expect(BCrypt::Password.new(user.password_digest)).to eq('123teste')

      patch :update_password, params: { id: user.id, user: {
        old_password: '123teste',
        password: ''
      } }

      expect(response).to have_http_status(:unprocessable_entity)

      user.reload

      expect(BCrypt::Password.new(user.password_digest)).to eq('123teste')
    end
  end

  # describe 'DELETE #destroy' do
  #   before do
  #     5.times do
  #       create(:user)
  #     end
  #   end

  #   it '' do
  #   end
  # end
end
