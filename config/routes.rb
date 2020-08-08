Rails.application.routes.draw do

  root 'sessions#welcome'

  get '/log_in', to: 'sessions#new'
  post '/log_in', to: 'sessions#create'
  post '/log_out', to: 'sessions#destroy'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  
  get '/posts/today', to: 'posts#today'
  post '/posts/:id/delete', to: 'posts#destroy', as: 'delete_post'

  resources :categories, only:[:index, :show] do 
    resources :posts
  end

  resources :posts
  resources :users, only: [:new, :create, :show]
  resources :comments, only: [:create]

  get '*path', to: redirect { |route, req| req.flash[:error] = "The URL \"/#{route[:path]}\" Was Not Found!"; '/' }
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
