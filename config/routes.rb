Rails.application.routes.draw do
  root "pages#home"
  devise_for :users

  resources :links
  resources :private_links, controller: :links, type: "PrivateLink"
  resources :regular_links, controller: :links, type: "RegularLink"
  resources :ephemeral_links, controller: :links, type: "EphemeralLink"
  resources :temporary_links, controller: :links, type: "TemporaryLink"
end
