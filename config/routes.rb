Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             }, controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
  get '/events/participate', to: 'events#participate'
  get '/events/organize', to: 'events#organize'

  resources :events
  resources :bookings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
