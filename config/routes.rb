Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :events do
    resources :bookings, only: %i[create new]
  end
end
