Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "dashboard", to: "pages#dashboard"
  resources :events do
    resources :bookings, only: %i[create new show]
  end
  resources :bookings do
    member do
      get :accept
      post :accept
      get :decline
      post :decline
    end
  end
end
