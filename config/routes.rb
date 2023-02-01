Rails.application.routes.draw do
  devise_for :users
  get "/books/:id/book_comments" => "books#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get "home/about" => "homes#about", as:"about"
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users
end
