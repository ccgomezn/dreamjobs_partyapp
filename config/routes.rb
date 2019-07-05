Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :user do
    member do
      get :confirm_email
    end
  end
  resources :service

end
