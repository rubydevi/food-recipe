Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :recipes do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end

  resources :foods, only: [:index, :show, :new, :create, :destroy]
  resources :public_recipes, only: [:index]

  resources :shopping_lists, only: [:index] do
    collection do
      get 'generate'
    end
  end

  get 'public_recipes_custom', to: 'recipes#public_recipes', as: 'public_recipes_custom'
end
