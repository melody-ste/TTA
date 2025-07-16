Rails.application.routes.draw do
  resources :projects
  resources :cities
  resources :architects
  resources :specializations
  devise_for :users
  root 'home#home'

  get 'legal_notice', to: 'static_pages#legal_notice'
  get 'rgpd', to: 'static_pages#rgpd'
  get 'cgv', to: 'static_pages#cgv'
  get 'faq', to: 'static_pages#faq'
end
