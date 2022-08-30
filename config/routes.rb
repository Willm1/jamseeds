Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  get "css_template", to: "pages#css_template"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: %i[index show destroy] do
    resources :instruments, only: %i[index show destroy]
    resources :genres, only: %i[index show destroy]
  end
end
