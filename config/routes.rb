Rails.application.routes.draw do
  resources :products do
    resources :reviews
  end
  root 'store#index'
end
