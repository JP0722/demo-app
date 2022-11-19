Rails.application.routes.draw do
  get 'pages/home'
  root 'welcome#index'
  resources :users , except: [:new]
  resources :hotels
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'forgot', to: 'forgot#show'
  post 'forgot', to: 'forgot#sendmail'
  get 'forgot/:id/reset', to: 'reset#show'
  post 'forgot/:id/reset', to: 'reset#update'
  get 'users/:id/hotels', to: 'users#show_hotels'
end
