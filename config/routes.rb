Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :recipes do
    resources :recipes_foods, only: [:new, :create, :destroy]
  end

  resources :foods, only: [:index, :show, :new, :create, :destroy]
  resources :public_recipes, only: [:index]
  # get routes
  get 'shopping_list', to: 'shopping_lists#show'
  get 'public_recipes', to: 'recipes#public_recipes'
end
