Rails.application.routes.draw do
  resources :survey_volunteer_sign_ups, only: [:new, :create]
  resources :survey_provider_requests, only: [:new, :create]

  root 'home#index'
end
