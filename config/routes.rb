Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :groups, only: [:index, :new, :create] do
    member do
      get :invite
      post :invitation_response
    end
  end
end
