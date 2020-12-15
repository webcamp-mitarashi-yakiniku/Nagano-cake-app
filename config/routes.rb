Rails.application.routes.draw do

  devise_for :admins, path: 'admin',controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :customers, path: '',controllers: {
    sessions: 'customer/sessions',
    registrations: 'customer/registrations',
    passwords: 'customer/passwords'
  }

  namespace :customer do
    get 'homes/top'
    get 'homes/about'
  end


end
