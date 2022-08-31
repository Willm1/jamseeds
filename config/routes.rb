Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  get "css_template", to: "pages#css_template"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :user_instruments, only: %i[new create destroy]

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: %i[index show destroy] do
    resources :genres, only: %i[index show destroy]
  end

  resources :instruments, only: %i[index show]
end
