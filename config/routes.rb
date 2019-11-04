Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #all routes will be /api/v1/<route>
  namespace :api do
    namespace :v1 do
      resources :book_lists, only: [:create, :destroy]
      resources :books, only: [:create]
      resources :book_list_books, only: [:create]
      delete "/book_list_books", to: "book_list_books#destroy"
      get "/search", to: "books#search"
      post "/login", to: "auth#login"
      get "/auto_login", to: "auth#auto_login"
      post "/signup", to: "users#create"
      delete "/users", to: "users#destroy"
    end
  end
end
