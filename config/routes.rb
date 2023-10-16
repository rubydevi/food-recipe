Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :recipes do
    resources :recipes_foods, only: [:new, :create, :destroy]
  end

  resources :foods, only: [:index, :show, :new, :create, :destroy]
  resources :public_recipes, only: [:index]

  resources :shopping_lists, only: [:index] do
    collection do
      get 'generate'
    end
  end

  # Renamed the route to follow Rails conventions
  get 'public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'
end
