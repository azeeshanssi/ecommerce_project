Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  mount ActionCable.server => '/cable'
  resources :categories do
    resources :products do
      resources :comments do
        post 'create_reply', on: :member
        delete 'destroy_reply', on: :member
      end
    end
  end
  resources :carts
  post 'carts/add_selected_products', to: 'carts#add_selected_products', as: :add_selected_products_to_cart
  resources :cart_items
  # Defines the root path route ("/")
  # root "articles#index"
end
