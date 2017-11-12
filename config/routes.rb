Rails.application.routes.draw do
  get 'comments/new'

  get 'comments/create'

  resources :cocktails do
    resources :doses, only: [:new, :create]
    resources :comments, only: [:new, :create]
  end

  resources :doses, only: [:destroy]
  root to: 'cocktails#index'
  get 'profile', to: 'cocktails#profile'
  get 'search', to: 'cocktails#search'
  mount Attachinary::Engine => "/attachinary"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
