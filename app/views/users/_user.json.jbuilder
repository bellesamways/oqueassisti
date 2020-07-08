json.extract! user, :id, :name, :email, :username, :list_id, :created_at, :updated_at
json.url user_url(user, format: :json)
