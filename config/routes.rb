Rails.application.routes.draw do
  root "pages#home"
  devise_for :users
  devise_scope :user do
      post 'users/sign_up', to: 'devise/registrations#create'
      put 'users/edit', to: 'devise/registrations#update'
  end

  resources :links
  resources :private_links, controller: :links
  resources :regular_links, controller: :links
  resources :ephemeral_links, controller: :links
  resources :temporary_links, controller: :links

  resources :reports, only: [] do
    member do
      get 'access_logs'
      get 'date_count'
      get 'day_count'
    end
  end

  get 'l/:slug', to: 'access#show'
  get 'l/:slug/private', to: 'access#private', as: "private_access"
  post 'l/:slug/private', to: 'access#authorize', as: "authorize_access"
end
