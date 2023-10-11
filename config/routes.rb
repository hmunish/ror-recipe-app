Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :recipes
    resources :foods
    resources :recipe_foods, except: %i[edit update]
    resources :public_recipes, only: [:index]
    resources :shopping_list, only: [:index, :show]
  end
end
