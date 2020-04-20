Rails.application.routes.draw do
  resources :survey_volunteer_sign_ups, only: [:new, :create]
  get :provider_request, to: 'survey_provider_requests#new'

  root 'home#index'
end
