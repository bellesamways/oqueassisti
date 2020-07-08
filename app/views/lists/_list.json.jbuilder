json.extract! list, :id, :name, :type, :user_id, :movie_id, :show_id, :created_at, :updated_at
json.url list_url(list, format: :json)
