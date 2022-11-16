Rails.application.routes.draw do
  root 'welcome#index'
  resources :users , except: [:new]
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'forgot', to: 'forgot#show'
  post 'forgot', to: 'forgot#sendmail'
end
