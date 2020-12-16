Rails.application.routes.draw do

  devise_for :admins, path: 'admin',controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :customers, path: '',controllers: {
    sessions: 'customer/sessions',
    registrations: 'customer/registrations',
    passwords: 'customer/passwords'
  }

  namespace :admin do
    resources :orders, only: [:index, :show, :update] do
      resources :order_products, only: [:update]
    end
    resources :users, only: [:index, :show, :edit, :update]
  end

  scope module: 'customer' do
    root 'homes#top'
    get 'about' => 'homes#about'

    resource :users, only: [:show, :edit, :update, :destroy] do
      get 'exit' => 'users#exit'
    end
    resources :delivery_addresses, only: [:index, :create, :edit, :update, :destroy]

  end


end
