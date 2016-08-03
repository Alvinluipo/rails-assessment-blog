Rails.application.routes.draw do
devise_for :users, :path => 'accounts', :controllers => { registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users do
      resources :posts
  end
  resources :posts, only: [:index, :new, :create, :show]
  resources :comments

  resources :tags

  root "posts#index"

  get '/about', to: 'pages#about'



  

end


