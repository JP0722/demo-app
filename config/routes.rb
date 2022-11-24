Rails.application.routes.draw do
  get 'booking/new'
  get 'pages/home'
  root 'welcome#index'
  resources :users , except: [:new]
  resources :hotels
  resources :bookings
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'forgot', to: 'forgot#show'
  post 'forgot', to: 'forgot#sendmail'
  resources :reviews, only: [:create, :destroy]
  get 'forgot/:id/reset', to: 'reset#show'
  post 'forgot/:id/reset', to: 'reset#update'
  get 'users/:id/hotels', to: 'users#show_hotels'
  get 'users/:id/bookings', to: 'users#show_bookings'
  get 'hotels/:id/bookings', to: 'hotels#show_bookings'
  get 'payment', to:'pages#spinner'
end
