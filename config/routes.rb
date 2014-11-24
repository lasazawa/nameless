Rails.application.routes.draw do


root 'access#login'
post 'login', to: 'access#attempt_login'
get 'logout', to: 'access#logout'
post 'users/:user_id/projects/:id', to: 'projects#vote', as: 'vote'
post 'users/:id/tag', to: 'users#tag', as: 'tag'
post 'users/:user_id/projects/:id/name', to: 'projects#name', as: 'name'

#Users
resources :users, only: [:new, :create, :show, :edit, :update] do

  #Projects
  resources :projects,  only: [:show, :new, :create, :edit,  :update] do

    #Comments
    resources :comments, only: [:index, :show, :create]

  end
end

#tags
resources :tag, only: [:show, :create]

post 'pay', to: 'projects#pay'


end
