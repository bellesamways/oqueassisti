json.extract! movie, :id, :title, :status, :original_id, :list_id, :user_id, :created_at, :updated_at
json.url movie_url(movie, format: :json)
