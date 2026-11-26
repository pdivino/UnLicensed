Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "products#index"

  get "search", to: "products#search", as: :search

  get "cart", to: "carts#show", as: :cart
  post "cart/add/:id", to: "carts#add", as: :add_to_cart

  # Checkout: fill in the address form, place the order, see the invoice.
  get "checkout", to: "orders#new", as: :checkout
  post "orders", to: "orders#create", as: :orders
  get "orders/:id", to: "orders#show", as: :order

  resources :products, only: [ :index, :show ]
  resources :categories, only: [ :show ]

  get "up" => "rails/health#show", as: :rails_health_check
end