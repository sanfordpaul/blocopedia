Rails.application.routes.draw do
  devise_for :users
  resources :wikis
  resources :collaborations, only: [:new, :create, :destroy]
  resources :charges, only: [:new, :create]
  resources :refunds, only: [:new, :create]

  get 'collaborations/:id' => 'collaborations#show', as: "show_collaborations_for_wiki"
  patch 'collaborations/:id' => 'collaborations#update', as: "update_collaborations_for_wiki"
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
