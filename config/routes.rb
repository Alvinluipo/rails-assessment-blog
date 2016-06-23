Rails.application.routes.draw do
devise_for :users, :path => 'accounts', :controllers => { registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :posts  do 
    resources :comments
  end


  root "posts#index"

  get '/about', to: 'pages#about'

  

end


