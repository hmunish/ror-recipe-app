Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :recipes, only: [:index, :show, :new, :create, :destroy] do
      member do
        patch :public_toggle
      end
    end
    resources :foods, only: [:index, :show, :new, :create, :destroy]
    resources :recipe_foods, except: %i[edit update] do
      patch :modify, on: :member
    end
    resources :public_recipes, only: [:index]
    resources :shopping_list, only: [:index]
  end
end
