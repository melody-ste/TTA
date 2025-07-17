Rails.application.routes.draw do
  resources :projects
  resources :cities
  resources :architects
  devise_for :users
  resources :specializations
  resources :multimedias
  get 'search', to: 'search#index'
  root 'home#home'

  get 'legal_notice', to: 'static_pages#legal_notice'
  get 'rgpd', to: 'static_pages#rgpd'
  get 'cgv', to: 'static_pages#cgv'
  get 'faq', to: 'static_pages#faq'
end
