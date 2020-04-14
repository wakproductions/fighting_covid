Rails.application.routes.draw do
  get :provider_request, to: 'home#provider_request'
  get :volunteer_sign_up, to: 'home#volunteer_sign_up'

  root 'home#index'
end
