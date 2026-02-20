Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get "/home", to: "signup#index"
  get "/new", to: "signup#new"
  post "/create", to: "signup#create"


  get "/login",  to: "sessions#new"
 post   "/login",  to: "sessions#create"
 delete "/logout", to: "sessions#destroy", as: :logout

  resources :restaurants do
    resources :dishes do
     collection do
      get "search"
     end
    end
      resources :orders, only: [ :index, :show ],   controller: "restaurant_orders" do
    member do
      patch :update_status
    end
  end
end

  namespace :customers do
  get "dashboard", to: "dashboard#index"
  get "dashboard/:id/dishes", to: "dashboard#show"
  get "search", to: "dashboard#search"
  get "search_dish/:id", to: "dashboard#search_dish", as: :search_dish
  post "rating/:id", to: "dashboard#rating", as: :rating
end

resource :cart, only: [ :show ] do
  post "add/:dish_id", to: "carts#add", as: :add
  patch "increase/:id", to: "carts#increase", as: :increase
  patch "decrease/:id", to: "carts#decrease", as: :decrease
  delete "remove/:item_id", to: "carts#remove", as: :remove
end

resources :orders, only: [  :index, :show ] do
 collection do
    post :preview
    post :confirm
    get :preview_page
  end

 member do
    patch :cancel
    get "message", to: "orders#message", as: :message
    post "message/save", to: "orders#message_save", as: :message_save
  end
end


match "*unmatched_route", to: redirect("/"), via: :all

mount ActionCable.server => "/cable"

 root "signup#index"























  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
