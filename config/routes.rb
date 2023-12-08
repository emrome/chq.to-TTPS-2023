Rails.application.routes.draw do
  root "pages#home"
  devise_for :users
  devise_scope :user do
      post 'users/sign_up', to: 'devise/registrations#create'
      put 'users/edit', to: 'devise/registrations#update'
  end

  resources :links
  resources :private_links, controller: :links, type: "PrivateLink"
  resources :regular_links, controller: :links, type: "RegularLink"
  resources :ephemeral_links, controller: :links, type: "EphemeralLink"
  resources :temporary_links, controller: :links, type: "TemporaryLink"
end
