Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #all routes will be /api/v1/<route>
  namespace :api do
    namespace :v1 do
      resources :users
      resources :authors, only: [:index, :show]
      resources :book_lists
      resources :book_list_books
      get "/search", to:"books#search"
    end
  end
end
