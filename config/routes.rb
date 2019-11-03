Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #all routes will be /api/v1/<route>
  namespace :api do
    namespace :v1 do
      resources :book_lists, only: [:create]
      resources :books, only: [:create]
      resources :book_list_books, only: [:create]
      get "/search", to: "books#search"
      post "/login", to: "auth#login"
      post "/signup", to: "users#create"
			get "/auto_login", to: "auth#auto_login"
    end
  end
end
