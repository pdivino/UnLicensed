Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Front page shows the product list (rubric 2.1).
  root "products#index"

  # /search?keyword=hoodie&category_id=3 runs the product search (rubric 2.6).
  get "search", to: "products#search", as: :search

  # Shopping cart (rubric 3.1.1): view the cart, and add a product to it.
  get "cart", to: "carts#show", as: :cart
  post "cart/add/:id", to: "carts#add", as: :add_to_cart

  # /products (list) and /products/1 (one product's page) (rubric 2.3).
  resources :products, only: [ :index, :show ]

  # /categories/1 shows only that category's products (rubric 2.2).
  resources :categories, only: [ :show ]

  # Health check page Rails uses to see if the app is running.
  get "up" => "rails/health#show", as: :rails_health_check
end