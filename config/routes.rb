Rails.application.routes.draw do


root 'access#login'
post 'login', to: 'access#attempt_login'
get 'logout', to: 'access#logout'
post 'users/:user_id/projects/:id', to: 'projects#vote', as: 'vote'

#Users
resources :users, only: [:new, :create, :show, :edit, :update] do

  #Projects
  resources :projects,  only: [:show, :new, :create, :edit,  :update]

end

#tags
resources :tag, only: [:show, :create]

end
