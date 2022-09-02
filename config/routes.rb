Rails.application.routes.draw do

  get 'user_genres/new'

  devise_for :users
  root to: "pages#home"
  get "css_template", to: "pages#css_template"
  get "start_chat", to: "users#chatroom"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :user_instruments, only: %i[new create destroy]
  resources :user_genres, only: %i[new create destroy]

  # Defines the root path route ("/")
  # root "articles#index"
  get "profile", to: "users#my_profile"

  resources :users do
    resources :genres, only: %i[index show destroy]
  end

  resources :chatrooms do
    resources :messages
  end
  resources :instruments, only: %i[index show]
end
