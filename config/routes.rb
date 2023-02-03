Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :employees do
    member do
      get :count
    end
  end

end
