Rails.application.routes.draw do
  # TODO: uncomment later
  # resource :session
  # resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # API routes
  namespace :api do
    post "heroes/load", to: "heroes#load"
    post "heroes/save", to: "heroes#save"
    post "roll", to: "rolls#create"
    get "game/current", to: "games#current"
    get "game/party", to: "games#party"
    get "game/logs", to: "games#logs"
  end

  # DM Dashboard
  namespace :master do
    root to: "heroes#index"

    resources :heroes, only: [ :index, :show, :update, :destroy ] do
      member do
        post :duplicate
      end
    end
    resources :hero_templates

    resources :games do
      member do
        get :settings
        post :manage_hero
        patch :update_notes
        post :toggle_active
      end
    end
  end

  # Heroes & Adeventures app
  resources :sessions, only: [ :new, :create, :destroy ]
  namespace :tg do
    root to: "home#index"
    post "auth", to: "home#auth"
    get "account", to: "account#index"
    put "account", to: "account#update"
  end
  resources :characters, only: [ :index, :show, :new, :create ]

  namespace :dw, path: "characters/:character_param/dw" do
    resources :moves, only: [ :index ]
    resources :spells, only: [ :index ]
    resources :party, only: [ :index ]
    resources :adventure, only: [ :index ]
  end


  root "sessions#new"
end
