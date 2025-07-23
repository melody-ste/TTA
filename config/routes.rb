Rails.application.routes.draw do
  resources :projects
  resources :cities
  resources :architects
  resources :specializations
  resources :multimedias

  devise_for :users
  resources :users, only: [ :show, :edit, :update, :destroy ] do
    resources :avatars, only: [ :create, :edit, :update, :destroy ]
    member do
      post "like", to: "likes#create"
      delete "unlike", to: "likes#destroy"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "search", to: "search#index"
  root "home#home"

  get "legal_notice", to: "static_pages#legal_notice"
  get "rgpd", to: "static_pages#rgpd"
  get "cgv", to: "static_pages#cgv"
  get "faq", to: "static_pages#faq"
end
