Rails.application.routes.draw do

  get 'search' => 'search#locate'

  devise_for :admins, path: 'admin',controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :customers, path: '',controllers: {
    sessions: 'customer/sessions',
    registrations: 'customer/registrations',
    passwords: 'customer/passwords'
  }

  namespace :admin do
    get '/' => 'homes#top'
    resources :orders, only: [:index, :show, :update] do
      resources :order_products, only: [:update]
    end
    resources :users, only: [:index, :show, :edit, :update]
    resources :products, only: [:new, :index, :show, :edit, :update, :create]
    resources :genres, only: [:index, :create, :edit, :update]
  end

  scope module: 'customer' do
    root 'homes#top'
    get 'about' => 'homes#about'

    resource :users, only: [:show, :edit, :update, :destroy] do
      get 'exit' => 'users#exit'
    end
    resources :cart_products, only: [ :create, :index ,:update, :destroy]
    delete 'cart_products/empty' => 'cart_products#empty'
    resources :delivery_addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :products, only: [:index, :show]
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/thanks' => 'orders#thanks'
    resources :orders, only: [:index, :show, :new]
  end
end
