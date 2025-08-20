Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'

  scope 'auth' do
    devise_for :users, controllers: {
      sessions: 'users/sessions'
    }, path: 'user', path_names: { sign_in: 'login', sign_out: 'logout'}
  end

  resources :users
  resources :inscriptions
  resources :regions
  resources :years
  resources :settings
  resources :payments, only: [:create, :update]
  resources :candidates do
    collection do
      get 'candidate_name'
    end
  end

  resource :dashboards, only: [:show]
  
  resources :contacts, only: [:create]
  resources :chechout_pages, only: [:index]
  
  root to: 'clients#index'
  get 'current_time', to: 'time#current_time'
  match 'politique-de-confidentialite', to: 'static_pages#privacy_policy', via: %i[get], as: "privacy_policy"
  match 'terme-et-service', to: 'static_pages#terms', via: %i[get], as: "terms"
  match 'galeries', to: 'galleries#index', via: %i[get], as: "galeries"

  post 'webhook', to: 'payments#webhook', as: 'webhook'

  # match 'webhook', to: 'chat_bots#webhook', via: %i[post]

  # error pages
  %w( 404 422 500 503 ).each do |code|
    get code, :to => "errors#show", :code => code
  end
end
