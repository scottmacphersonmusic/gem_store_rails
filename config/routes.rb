Rails.application.routes.draw do
  resources :products
  root 'store#index'
end
