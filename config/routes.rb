Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :user do
    member do
      get :confirm_email
    end
  end  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
