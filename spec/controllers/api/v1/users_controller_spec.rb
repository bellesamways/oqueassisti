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
      expect(response.body).to have_content "can't be blank"
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

  # describe 'PATCH #update' do
  #   it 'returns ok when change the name to a valid name' do
  #     user = create(:user,
  #                   name: 'teste legal',
  #                   email: 'testelegal@teste.com',
  #                   username: 'testelegal',
  #                   password: '123teste'
  #                   )

  #     patch :update, params: {
  #       id: user.id,
  #       "user": {
  #         name: 'legal teste'
  #       }
  #     }
  #     debugger

  #     expect(response).to have_http_status(:ok)
  #     expect(response.body).to have_content 'legal teste'
  #   end
  # end
end
