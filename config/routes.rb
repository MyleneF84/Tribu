Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "dashboard", to: "pages#dashboard"
  resources :events do
    resources :bookings, only: %i[create new show]
  end
end
