Rails.application.routes.draw do
  root 'pages#home'
  get '/home', to: 'pages#home'
  
  #get '/recipes', to: 'recipes#index'
  #get '/recipes/new', to: 'recipes#new', as: 'new_recipe' # the route will be: something.com/new_recipe
  
  #to create
  #post '/recipes', to: 'recipes#create'
  
  #get '/recipes/:id/edit', to: 'recipes#edit', as: 'edit_recipe'
  
  #handle submission / update
  #patch '/recipes/:id', to: 'recipes#update'
  
  #get 'recipes/:id', to: 'recipes#show', as: 'recipe'
  #delete '/recipes/:id', to: 'recipes#destroy'
  
  
  #another way to get all the above standard routes
  resources :recipes do
    # create a like path for a recipe
    member do
      post 'like'  
    end
  end
  
  resources :chefs, except: [:new,:destroy] 
  #we want the URL to be  .../register, not .../new for new_chef
  get '/register', to: 'chefs#new'
  
  
  #login -> new session
  get '/login', to: "logins#new"
  #logout -> close session
  post '/login', to: "logins#create"
  #post login -> create session
  get '/logout', to: "logins#destroy"
  
  
  resources :styles, only: [:new,:create, :show]
  resources :ingredients, only: [:new,:create, :show]
  
end
