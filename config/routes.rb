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
