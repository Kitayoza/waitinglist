Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root 'pages#main'

  get 'main', to: 'pages#main'

  # Регистрация
  get 'signup', to: 'registrations#new', as: 'new_registration'
  post 'signup', to: 'registrations#create', as: 'registrations'

  # Аутентификация
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  # Дублирующийся маршрут уже объявлен выше, поэтому его можно удалить
  # get 'pages/main'

  resources :appointments, only: [:create]

  post 'appointments', to: 'appointments#create'
end