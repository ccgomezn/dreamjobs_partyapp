Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :user do
    member do
      get :confirm_email
      post :desactivate_user
    end
  end
  resources :service
  resources :employee
  resources :services_user do 
    member do
      put :rate
    end
  end

end
