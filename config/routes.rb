Rails.application.routes.draw do
  resources :users
  resources :admins, except: %i[index new]
  resources :conversations do
    resources :messages
  end
  resources :projects do
    resources :articles
  end
  root 'users#index'
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/login' => 'sessions#new'
  get '/admin/login' => 'sessions#admin_new'
  get '/admin' => 'admins#index'
  get '/admin/signup' => 'admins#new'
  post '/admin/login' => 'sessions#admin_create'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  put '/user/:id' => 'users#approve', as: 'approve'
  get 'password/reset' => 'password_resets#new'
  post 'password/reset' => 'password_resets#create'
  get 'password/reset/edit' => 'password_resets#edit'
  post 'password/reset/edit' => 'password_resets#update'
  get '/admin/password/reset' => 'password_resets#admin_new'
  post '/admin/password/reset' => 'password_resets#admin_create'
  get '/admin/password/reset/edit' => 'password_resets#admin_edit'
  post '/admin/password/reset/edit' => 'password_resets#admin_update'
end
