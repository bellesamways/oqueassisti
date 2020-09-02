Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users, except: %i[new edit]
      patch '/update_password/:id', controller: :users, action: :update_password
    end
  end
  resources :episodes
  resources :seasons
  resources :shows
  resources :movies
  resources :lists

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
