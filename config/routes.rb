Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get 'home/index'
  
  root to: "categories#index"
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
  match '*unmatched', to: 'application#not_found_method', via: :all
  
end
