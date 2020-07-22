json.extract! user, :id, :name, :email, :username, :created_at, :updated_at
json.url api_v1_user_url(user, format: :json)
